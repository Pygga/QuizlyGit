//
//  ProfileTests.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 12.06.2025.
//


import XCTest
@testable import QuizlyGit

class ProfileTests: XCTestCase {
    
    // MARK: - Тест базовой инициализации
    func testProfileInitialization() {
        let profile = Profile(
            id: "USER123",
            name: "John Doe",
            email: "john@example.com",
            score: 1000
        )
        
        XCTAssertEqual(profile.id, "USER123")
        XCTAssertEqual(profile.name, "John Doe")
        XCTAssertEqual(profile.email, "john@example.com")
        XCTAssertEqual(profile.score, 1000)
        XCTAssertNil(profile.avatarURL)
    }
    
    // MARK: - Тест сравнения профилей
    func testProfileEquality() {
        let profile1 = Profile(id: "1", name: "A", email: "a@test.com", score: 100)
        let profile2 = Profile(id: "1", name: "B", email: "b@test.com", score: 200)
        let profile3 = Profile(id: "2", name: "A", email: "a@test.com", score: 100)
        
        // Проверка равенства по ID
        XCTAssertEqual(profile1, profile2, "Профили с одинаковым ID должны быть равны")
        XCTAssertNotEqual(profile1, profile3, "Профили с разным ID не должны быть равны")
    }
    
    // MARK: - Тест преобразования в словарь
    func testProfileRepresentation() {
        let profile = Profile(
            id: "USER123",
            name: "Jane Smith",
            email: "jane@example.com",
            score: 1500
        )
        profile.avatarURL = URL(string: "https://avatar.com/jane.jpg")
        
        let representation = profile.representation
        
        // Проверка корректности преобразования
        XCTAssertEqual(representation["id"] as? String, "USER123")
        XCTAssertEqual(representation["name"] as? String, "Jane Smith")
        XCTAssertEqual(representation["email"] as? String, "jane@example.com")
        XCTAssertEqual(representation["score"] as? Int, 1500)
        XCTAssertEqual(representation["avatarURL"] as? String, "https://avatar.com/jane.jpg")
    }
    
    // MARK: - Тест инициализации из словаря
    func testProfileFromRepresentation() {
        let representation: [String: Any] = [
            "id": "USER456",
            "name": "Bob Brown",
            "email": "bob@example.com",
            "score": 2000,
            "avatarURL": "https://avatar.com/bob.jpg"
        ]
        
        let profile = Profile(representation: representation)
        
        // Проверка корректности преобразования
        XCTAssertNotNil(profile)
        XCTAssertEqual(profile?.id, "USER456")
        XCTAssertEqual(profile?.avatarURL, URL(string: "https://avatar.com/bob.jpg"))
    }
    
    // MARK: - Тест обработки ошибок в представлении
    func testInvalidRepresentation() {
        // Неполные данные (без обязательного поля "email")
        let invalidRepresentation: [String: Any] = [
            "id": "USER789",
            "name": "Invalid User",
            "score": 500
        ]
        
        let profile = Profile(representation: invalidRepresentation)
        XCTAssertNil(profile, "Инициализация должна вернуть nil при невалидных данных")
    }
}
