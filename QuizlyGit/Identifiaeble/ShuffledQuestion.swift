//
//  ShuffledQuestion.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 27.05.2025.
//
import Foundation

struct ShuffledQuestion: Identifiable {
    let id: String
    let original: Question
    let answers: [String]
    let correctAnswerIndex: Int
    
    var hint: Hint {
        original.hint
    }
    
    var codeExample: String? {
        original.codeExample
    }
}
