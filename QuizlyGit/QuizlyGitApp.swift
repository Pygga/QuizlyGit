//
//  QuizlyGitApp.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import SwiftUI
import FirebaseCore

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
    // register app delegate for Firebase setup
    @State private var questionStorage = QuestionStorage.shared
    @State private var isLoading = true
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoading {
                    ProgressView(
                        "Загрузка вопросов..."
                    )
                } else {
                    NavigationView {
                        ContentView()
                            .preferredColorScheme(userTheme.colorScheme)
                    }
                }
            }
            .task {
                do {
                    try await questionStorage.loadQuestions()
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
}
