//
//  QuizlyGitApp.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct QuizlyGitApp: App {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @AppStorage("log_status") var logStatus: Bool = false
    @StateObject var localization = LocalizationManager.shared
    // register app delegate for Firebase setup
    @State private var questionStorage = QuestionStorage.shared
    @State private var isLoading = true
    @State private var progress: Double? = nil
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoading {
                    LoadingRingView(text: "Загрузка вопросов", progress: $progress)
                        .preferredColorScheme(userTheme.colorScheme)
                } else {
                    NavigationView {
                        ContentView()
                            .environmentObject(localization)
                            .preferredColorScheme(userTheme.colorScheme)
                            .environment(\.locale, Locale(identifier: localization.currentLanguage))
                    }
                }
            }
            .task {
                do {
                    async let questions: () = QuestionStorage.shared.loadQuestions()
                    async let settings: () = loadUserSettings()
                                        
                    _ = try await (questions, settings)
                    isLoading = false
                } catch {
                    print(
                        "Ошибка загрузки вопросов: \(error)"
                    )
                    // Обработка ошибки
                }
            }
        } 
    }
    
    private func loadUserSettings() async {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        do {
            let settings = try await FirestoreService.shared.getSettings(userId: userId)
            await MainActor.run {
                localization.currentLanguage = settings.language
            }
        } catch {
            print("Ошибка загрузки настроек: \(error)")
        }
    }
}
