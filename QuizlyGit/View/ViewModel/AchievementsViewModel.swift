//
//  AchievementsViewModel.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 31.05.2025.
//


import Foundation
class AchievementsViewModel: ObservableObject {
    @Published var achievements: [Achievement] = []
    @Published var selectedAchievement: Achievement?
    
    func loadAchievements() {
        achievements = AchievementManager.shared.getAllAchievements()
    }
}