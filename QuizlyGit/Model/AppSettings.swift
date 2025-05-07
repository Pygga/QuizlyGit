//
//  AppSettings.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 06.05.2025.
//
import Foundation

// MARK: - Модель настроек
struct AppSettings: Codable {
    var language: String = "ru"
    var notificationsEnabled: Bool = true
    var theme: String = "system"
}
