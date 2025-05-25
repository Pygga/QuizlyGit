//
//  QuizConfig.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//
import Foundation

struct QuizConfig {
    var categories: [String]
    var isPresetTest: Bool
    var showHints: Bool  // Добавляем недостающее поле
    var timePerQuestion: Int
    var questionsCount: Int
    var stopOnWrongAnswer: Bool // Новый параметр для режима "До первой ошибки"
    // Добавляем инициализатор с значениями по умолчанию
    init(
        categories: [String] = [],
        isPresetTest: Bool = false,
        showHints: Bool = true,
        timePerQuestion: Int = 30,
        questionsCount: Int = 10,
        stopOnWrongAnswer: Bool = false
    ) {
        self.categories = categories
        self.isPresetTest = isPresetTest
        self.showHints = showHints
        self.timePerQuestion = timePerQuestion
        self.questionsCount = questionsCount
        self.stopOnWrongAnswer = stopOnWrongAnswer
    }
}
