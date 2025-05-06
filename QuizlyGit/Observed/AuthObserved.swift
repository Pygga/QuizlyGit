//
//  AuthObserved.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 30.04.2025.
//

import Foundation

extension AuthView {
    @Observable
    class Observed{
        var currentProfile: Profile?
        var errorMessage: String? // Для показа ошибок
        
        func auth(email: String, password: String){
            Task{
                do {
                    let profile = try await AuthService.shared.signIn(withEmail: email, password: password)
                    await MainActor.run {
                        self.currentProfile = profile
                    }
                } catch {
                    await MainActor.run {
                        self.errorMessage = "Ошибка входа: \(error.localizedDescription)"
                    }
                }
            }
        }
        
        func singUp(email: String, password: String, confirmPassword: String){
            guard password == confirmPassword else {
                errorMessage = "Пароли не совпадают"
                return
            }
            Task{
                do {
                    let profile = try await AuthService.shared.signUp(withEmail: email, password: password)
                    await MainActor.run {
                        self.currentProfile = profile
                    }
                } catch {
                    await MainActor.run {
                        self.errorMessage = "Ошибка регистрации: \(error.localizedDescription)"
                    }
                }
                
            }
            
        }
    }
}
