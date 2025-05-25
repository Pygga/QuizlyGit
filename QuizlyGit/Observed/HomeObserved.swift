//
//  HomeObserved.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 30.04.2025.
//

import Foundation
import SwiftUI
import FirebaseAuth

extension HomeView{
    @Observable
    class Observed{
        
        var availableCategories: [Category] = [
            Category(id: "1", name: "Git Basics", iconName: "doc.text", color: .blue),
            Category(id: "2", name: "Advanced", iconName: "gear", color: .green),
            Category(id: "3", name: "Branching", iconName: "arrow.triangle.branch", color: .orange),
            Category(id: "4", name: "Remote", iconName: "cloud", color: .purple),
            Category(id: "5", name: "Undo", iconName: "arrow.uturn.backward", color: .red)
        ]
        var selectedCategories: Set<String> = []
        var showingCategoryPicker = false
        var currentProfile: Profile
        var questions: [Question] = []
        
        var showHints: Bool = true
        var timePerQuestion: Int = 30
        var questionsCount: Int = 15
        
        var currentConfig: QuizConfig {
            QuizConfig(
                categories: Array(selectedCategories),
                showHints: showHints,
                timePerQuestion: timePerQuestion,
                questionsCount: questionsCount,
                stopOnWrongAnswer: false
            )
        }
        
        init() {
            self.currentProfile = Profile(id: "", name: "", email: "", score: 0)
            fetchData()
        }
        
        func updateProfile(_ newProfile: Profile) {
            currentProfile = newProfile
        }
        
        func fetchData(){
            Task{
                guard let userUID = Auth.auth().currentUser?.uid else { return }
                let profile = try await FirestoreService.shared.getProfile(userUID)
                await MainActor.run {
                    currentProfile = profile
                }   
            }
        }
        
        func toggleCategory(_ categoryId: String) {
            if selectedCategories.contains(categoryId) {
                selectedCategories.remove(categoryId)
            } else {
                selectedCategories.insert(categoryId)
            }
        }
    }
}
