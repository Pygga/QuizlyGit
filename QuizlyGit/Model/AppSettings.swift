//
//  AppSettings.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 06.05.2025.
//
import Foundation

// MARK: - Модель настроек
struct AppSettings {
    var language: String = "ru"
    var notificationsEnabled: Bool = true
}

extension AppSettings {
    init?(representation: [String: Any]) {
        guard let language = representation["language"] as? String,
              let notificationsEnabled = representation["notificationsEnabled"] as? Bool else {
            return nil
        }
        
        self.language = language
        self.notificationsEnabled = notificationsEnabled
    }
    
    var representation: [String: Any] {
        return [
            "language": language,
            "notificationsEnabled": notificationsEnabled
        ]
    }
}
