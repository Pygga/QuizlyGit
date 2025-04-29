//
//  UserAnswer.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import Foundation

struct UserAnswer: Codable {
    let questionId: String
    let answerIndex: Int
    let timestamp: Date
    var isCorrect: Bool
    var timeTaken: Double  // Время ответа в секундах
}


