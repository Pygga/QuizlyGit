//
//  AchievementManager.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 31.05.2025.
//


import SwiftUI
import Foundation

// MARK: - Менеджер достижений
class AchievementManager {
    static let shared = AchievementManager()
    private let userDefaultsKey = "userAchievements"
    
    // Предопределенные достижения
    static let achievements: [Achievement] = [
        Achievement(
            id: "games_15",
            title: "Новичок",
            description: "Сыграно 15 игр",
            imageName: "achievement_games15"
        ),
        Achievement(
            id: "games_30",
            title: "Опытный игрок",
            description: "Сыграно 30 игр",
            imageName: "achievement_games30"
        ),
        Achievement(
            id: "games_60",
            title: "Ветеран",
            description: "Сыграно 60 игр",
            imageName: "achievement_games60"
        ),
        Achievement(
            id: "time_1h",
            title: "Знаток времени",
            description: "Проведено в игре больше 1 часа",
            imageName: "achievement_time1h"
        ),
        Achievement(
            id: "time_10h",
            title: "Мастер времени",
            description: "Проведено в игре больше 10 часов",
            imageName: "achievement_time10h"
        ),
        Achievement(
            id: "correct_100",
            title: "Стобалльник",
            description: "100 правильных ответов",
            imageName: "achievement_correct100"
        ),
        Achievement(
            id: "correct_200",
            title: "Эксперт",
            description: "200 правильных ответов",
            imageName: "achievement_correct200"
        ),
        Achievement(
            id: "correct_300",
            title: "Гуру Git",
            description: "300 правильных ответов",
            imageName: "achievement_correct300"
        )
    ]
    
    private var userAchievements: [Achievement] = []
    
    init() {
        loadAchievements()
    }
    
    private func loadAchievements() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([Achievement].self, from: data) {
            userAchievements = decoded
        } else {
            // Первый запуск - инициализация
            userAchievements = AchievementManager.achievements
            saveAchievements()
        }
    }
    
    private func saveAchievements() {
        if let data = try? JSONEncoder().encode(userAchievements) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
    
    func checkAchievements(stats: UserStatistics) -> [Achievement] {
        var unlocked: [Achievement] = []
        
        for i in userAchievements.indices {
            if !userAchievements[i].isUnlocked {
                if let condition = AchievementUnlocker.condition(for: userAchievements[i].id),
                   condition(stats) {
                    userAchievements[i].isUnlocked = true
                    unlocked.append(userAchievements[i])
                }
            }
        }
        
        if !unlocked.isEmpty {
            saveAchievements()
        }
        
        return unlocked
    }
    
    func getAllAchievements() -> [Achievement] {
        return userAchievements
    }
    
    func resetAchievements() {
        userAchievements = AchievementManager.achievements
        saveAchievements()
    }
}