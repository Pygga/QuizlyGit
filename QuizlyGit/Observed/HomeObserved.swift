//
//  HomeObserved.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 30.04.2025.
//

import Foundation
import SwiftUI

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
        var currentProfile: Profile = .init(id: "", name: "", email: "", score: 0)
        var questions: [Question] = []
        
        init(userID: String = "yipyn1SlzIVDFt8bPu865TpfZpT2") {
            fetchData(userID: userID)
        }
        
        func fetchData(userID: String){
            Task{
                let profile = try await FirestoreService.shared.getProfile(userID)
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
