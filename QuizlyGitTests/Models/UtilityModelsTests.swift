//
//  UtilityModelsTests.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 12.06.2025.
//


import XCTest
import SwiftUI
@testable import QuizlyGit

class UtilityModelsTests: XCTestCase {
    
    // MARK: - Тест категорий
    func testCategory() {
        let category = Category(
            id: "cat1",
            name: "Git Basics",
            iconName: "git-icon",
            color: .blue
        )
        
        XCTAssertEqual(category.id, "cat1")
        XCTAssertEqual(category.name, "Git Basics")
        
        // Проверка соответствия Hashable
        let categories = Set([category])
        XCTAssertTrue(categories.contains(category))
    }
    
    // MARK: - Тест перемешанного вопроса
    func testShuffledQuestion() {
        let question = Question(
            text: "Test",
            answers: ["A", "B", "C"],
            correctAnswerIndex: 1,
            hint: Hint(text: "Hint", link: "link"),
            category: "Test"
        )
        
        let shuffled = ShuffledQuestion(
            id: "shuffled1",
            original: question,
            answers: ["B", "C", "A"], // Перемешанные ответы
            correctAnswerIndex: 0 // Правильный ответ теперь на 0 позиции
        )
        
        // Проверка свойств
        XCTAssertEqual(shuffled.id, "shuffled1")
        XCTAssertEqual(shuffled.original.text, "Test")
        XCTAssertEqual(shuffled.answers, ["B", "C", "A"])
        XCTAssertEqual(shuffled.correctAnswerIndex, 0)
        XCTAssertEqual(shuffled.hint.text, "Hint")
    }
    
    // MARK: - Тест участника рейтинга
    func testLeaderboardUser() {
        let user = LeaderboardUser(
            id: "user1",
            name: "Alice",
            avatarURL: URL(string: "https://avatar.com/alice.jpg"),
            totalScore: 2500,
            rank: .contributor,
            position: 3
        )
        
        XCTAssertEqual(user.name, "Alice")
        XCTAssertEqual(user.rank, .contributor)
        XCTAssertEqual(user.position, 3)
        XCTAssertEqual(user.avatarURL?.absoluteString, "https://avatar.com/alice.jpg")
    }
}
