//
//  AchievementUnlocker.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 31.05.2025.
//


import Foundation

// Отдельный класс для условий разблокировки
class AchievementUnlocker {
    private static var conditions: [String: (UserStatistics) -> Bool] = [
        "games_15": { $0.gamesPlayed >= 15 },
        "games_30": { $0.gamesPlayed >= 30 },
        "games_60": { $0.gamesPlayed >= 60 },
        "time_1h": { $0.totalPlayTime >= 3600 },
        "time_10h": { $0.totalPlayTime >= 36000 },
        "correct_100": { $0.correctAnswers >= 100 },
        "correct_200": { $0.correctAnswers >= 200 },
        "correct_300": { $0.correctAnswers >= 300 }
    ]
    
    static func condition(for id: String) -> ((UserStatistics) -> Bool)? {
        return conditions[id]
    }
}