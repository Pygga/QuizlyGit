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
        
        func auth(email: String, password: String){
            Task{
                let profile = try await AuthService.shared.signIn(withEmail: email, password: password)
                await MainActor.run{
                    self.currentProfile = profile
//                    HomeView.Observed.init(userID: profile.id).fetchData(userID: profile.id)
                }
            }
        }
        
        func singUp(email: String, password: String, confirmPassword: String){
            guard password == confirmPassword else {
                return
            }
            Task{
                let profile = try await AuthService.shared.signUp(withEmail: email, password: password)
                await MainActor.run{
                    self.currentProfile = profile
                }
                
            }
            
        }
    }
}
