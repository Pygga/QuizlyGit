//
//  Achievement.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 31.05.2025.
//


import Foundation
// MARK: - Модель достижения
struct Achievement: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let imageName: String
    var isUnlocked: Bool = false
    
    // Для Codable
    private enum CodingKeys: CodingKey {
        case id, title, description, imageName, isUnlocked
    }
}
