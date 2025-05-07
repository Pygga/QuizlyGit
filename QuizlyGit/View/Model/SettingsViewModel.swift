//
//  SettingsViewModel.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 06.05.2025.
//
import Foundation
import FirebaseAuth

// MARK: - SettingsViewModel
class SettingsViewModel: ObservableObject {
//    @Published var settings = AppSettings()
    
    @Published var settings = AppSettings() {
        didSet {
            saveSettingsWithDebounce()
        }
    }
    private var debounceTimer: Timer?
    
    @Published var currentUser: Profile = .init(id: "", name: "", email: "", score: 0)
    @Published var isLoading = false
    
    private let firestoreService = FirestoreService.shared
    private var userId: String
    
    init() {
        guard let user = Auth.auth().currentUser else {
            fatalError("User not authenticated")
        }
        self.userId = user.uid
    }
    
    func loadData() async {
        Task{
            do {
                async let settings = firestoreService.getSettings(userId: userId)
//                async let stats = firestoreService.getStatistics(userId: userId)
                let (loadedSettings) = await (try settings)
                let profile = try await FirestoreService.shared.getProfile(userId)
                print(profile)
                await MainActor.run {
                    self.settings = loadedSettings
                    self.currentUser = profile
//                    self.currentUser.score = loadedStats.totalScore
                }
            } catch {
                print("Error loading data: \(error)")
            }
        }
    }
    
    
    private func saveSettingsWithDebounce() {
        // Отменяем предыдущий таймер
        debounceTimer?.invalidate()
        
        // Запускаем новый таймер с задержкой 1 секунда
        debounceTimer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: false
        ) { [weak self] _ in
            self?.saveSettings()
        }
    }
    //Подстраховка
    private func saveSettings() {
        Task {
            do {
                try await firestoreService.updateSettings(
                    userId: userId,
                    settings: settings
                )
                print("Настройки успешно сохранены")
            } catch {
                print("Ошибка сохранения: \(error.localizedDescription)")
            }
        }
    }
    
    func saveSettings() async {
        do {
            try await firestoreService.updateSettings(userId: userId, settings: settings)
        } catch {
            print("Error saving settings: \(error)")
        }
    }
    
    func deleteAccount() {
        Task {
            do {
                guard let user = Auth.auth().currentUser else { return }
                
                // Удаление из Firestore
                try await firestoreService.profiles.document(user.uid).delete()
                
                // Удаление из Authentication
                try await user.delete()
                
                // Выход из системы
                await AuthService.shared.singOut()
                
            } catch {
                print("Ошибка удаления аккаунта")
            }
        }
    }
}
