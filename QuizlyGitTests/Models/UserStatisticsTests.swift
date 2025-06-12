//
//  UserStatisticsTests.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 12.06.2025.
//


import XCTest
@testable import QuizlyGit

class UserStatisticsTests: XCTestCase {
    
    // MARK: - Тест инициализации
    func testStatisticsInitialization() {
        let stats = UserStatistics(
            totalPlayTime: 3600,
            fastestQuiz: 120,
            slowestQuiz: 600,
            gamesPlayed: 10,
            questionsAnswered: 100,
            correctAnswers: 80,
            totalScore: 8000,
            hintsUsed: 15,
            incorrectAnswers: 20
        )
        
        XCTAssertEqual(stats.totalPlayTime, 3600)
        XCTAssertEqual(stats.correctAnswers, 80)
        XCTAssertEqual(stats.hintsUsed, 15)
    }
    
    // MARK: - Тест преобразования в словарь
    func testStatisticsRepresentation() {
        var stats = UserStatistics()
        stats.correctAnswers = 50
        stats.gamesPlayed = 5
        
        let representation = stats.representation
        
        XCTAssertEqual(representation["correctAnswers"] as? Int, 50)
        XCTAssertEqual(representation["gamesPlayed"] as? Int, 5)
        XCTAssertEqual(representation["hintsUsed"] as? Int, 0)
    }
}
