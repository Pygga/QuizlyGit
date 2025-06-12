//
//  ConfigAndSettingsTests.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 12.06.2025.
//


import XCTest
@testable import QuizlyGit

class ConfigAndSettingsTests: XCTestCase {
    
    // MARK: - Тест конфигурации квиза
    func testQuizConfig() {
        // Конфигурация по умолчанию
        let defaultConfig = QuizConfig()
        XCTAssertEqual(defaultConfig.questionsCount, 10)
        XCTAssertTrue(defaultConfig.showHints)
        XCTAssertFalse(defaultConfig.stopOnWrongAnswer)
        
        // Кастомная конфигурация
        let customConfig = QuizConfig(
            categories: ["Git", "Advanced"],
            showHints: false,
            timePerQuestion: 60,
            questionsCount: 20,
            stopOnWrongAnswer: true
        )
        
        XCTAssertEqual(customConfig.categories, ["Git", "Advanced"])
        XCTAssertEqual(customConfig.timePerQuestion, 60)
        XCTAssertTrue(customConfig.stopOnWrongAnswer)
    }
    
    // MARK: - Тест настроек приложения
    func testAppSettings() {
        // Инициализация по умолчанию
        var settings = AppSettings()
        XCTAssertEqual(settings.language, "ru")
        XCTAssertTrue(settings.notificationsEnabled)
        
        // Изменение значений
        settings.language = "en"
        settings.notificationsEnabled = false
        
        XCTAssertEqual(settings.language, "en")
        XCTAssertFalse(settings.notificationsEnabled)
    }
    
    // MARK: - Тест преобразования настроек
    func testSettingsRepresentation() {
        let settings = AppSettings(language: "fr", notificationsEnabled: false)
        let representation = settings.representation
        
        XCTAssertEqual(representation["language"] as? String, "fr")
        XCTAssertEqual(representation["notificationsEnabled"] as? Bool, false)
    }
    
    // MARK: - Тест инициализации настроек из словаря
    func testSettingsFromRepresentation() {
        let representation: [String: Any] = [
            "language": "es",
            "notificationsEnabled": true
        ]
        
        let settings = AppSettings(representation: representation)
        
        XCTAssertNotNil(settings)
        XCTAssertEqual(settings?.language, "es")
        XCTAssertTrue(settings?.notificationsEnabled ?? false)
    }
}
