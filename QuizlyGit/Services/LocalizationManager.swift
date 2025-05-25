//
//  LocalizationManager.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 23.05.2025.
//
import Foundation
import FirebaseAuth
import Combine
import FirebaseFirestore
import SwiftUI

class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()
    private let firestoreService = FirestoreService.shared
    private var userId: String { Auth.auth().currentUser!.uid }
    private var cancellables = Set<AnyCancellable>()
    
    @AppStorage("selectedLanguage") var currentLanguage: String = "ru" {
        didSet {
            if oldValue != currentLanguage {
                updateFirebaseLanguage()
            }
        }
    }
    
    private init() {
//        setupFirebaseListener()
        loadInitialLanguage()
    }
    
    private func loadInitialLanguage() {
        Task {
            do {
                let settings = try await firestoreService.getSettings(userId: userId)
                print(settings.language)
                print("Язык при инициализации лока менеджера")
                await MainActor.run {
                    self.currentLanguage = settings.language
                }
            } catch {
                print("Ошибка загрузки языка: \(error)")
            }
        }
    }
    
    private func updateFirebaseLanguage() {
        Task {
            do {
                var settings = try await firestoreService.getSettings(userId: userId)
                settings.language = currentLanguage
                print(settings.language)
                print("Язык при получении из firebase")
                try await firestoreService.updateSettings(userId: userId, settings: settings)
                print(settings.language)
                print("Язык который отправлен в firebase")
            } catch {
                print("Ошибка сохранения языка: \(error)")
                await revertLanguageOnError()
            }
        }
    }
    
    private func revertLanguageOnError() async {
        // Восстановление предыдущего значения при ошибке
        let correctLanguage = try? await firestoreService.getSettings(userId: userId).language
        await MainActor.run {
            self.currentLanguage = correctLanguage ?? "ru"
        }
    }
    
    func localizedString(_ key: String) -> String {
        NSLocalizedString(key, comment: "")
    }
}
