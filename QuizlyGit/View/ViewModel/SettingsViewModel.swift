//
//  SettingsViewModel.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 06.05.2025.
//
import Foundation
import FirebaseAuth
import SwiftUI

// MARK: - SettingsViewModel
class SettingsViewModel: ObservableObject {
    
    @Published var settings = AppSettings() {
        didSet {
            LocalizationManager.shared.currentLanguage = settings.language
        }
    }
    
    private var debounceTimer: Timer?
    
    @Published var currentUser: Profile = .init(id: "", name: "", email: "", score: 0)
    @Published var isLoading = false
    
    @Published var newName: String = ""
    @Published var newPassword: String = ""
    @Published var currentPassword: String = ""
    @Published var avatarImage: UIImage?
    @Published var showImagePicker: Bool = false
    
    private let observed: HomeView.Observed
    private let firestoreService = FirestoreService.shared
    private var userId: String
    
    init(observed: HomeView.Observed) {
        guard let user = Auth.auth().currentUser else {
            fatalError("User not authenticated")
        }
        self.userId = user.uid
        self.observed = observed
    }
    
    func loadData() async {
        do {
            let settings = try await FirestoreService.shared.getSettings(userId: userId)
            let profile = try await FirestoreService.shared.getProfile(userId)
            await MainActor.run {
                self.settings = settings
                self.currentUser = profile
                // Синхронизация с локальным менеджером
                LocalizationManager.shared.currentLanguage = settings.language
            }
        } catch {
            print("Ошибка загрузки настроек: \(error)")
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
    func saveSettings() {
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

    
    // Обновление имени
    func updateName() async {
        currentUser.name = newName
        do {
            try await firestoreService.updateProfile(currentUser)
            await MainActor.run {
                self.newName = ""
                observed.updateProfile(currentUser)
            }
        } catch {
            print("Ошибка обновления имени: \(error)")
        }
    }
    
    // Обновление аватара
    func updateAvatar() async {
        guard let imageData = avatarImage?.jpegData(compressionQuality: 0.8) else { return }
        
        do {
            let url = try await firestoreService.uploadAvatar(
                imageData: imageData,
                userId: userId
            )
            currentUser.avatarURL = url
            try await firestoreService.updateProfile(currentUser)
        } catch {
            print("Ошибка загрузки аватара: \(error)")
        }
    }
    
    // Смена пароля
    func changePassword() async {
        do {
            let user = Auth.auth().currentUser
            let credential = EmailAuthProvider.credential(
                withEmail: currentUser.email,
                password: currentPassword
            )
            
            try await user?.reauthenticate(with: credential)
            try await user?.updatePassword(to: newPassword)
            
            await MainActor.run {
                self.newPassword = ""
                self.currentPassword = ""
            }
        } catch {
            print("Ошибка смены пароля: \(error)")
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
