//
//  QuestionTests.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 12.06.2025.
//


import XCTest
@testable import QuizlyGit
import Firebase


class QuestionTests: XCTestCase {
    // MARK: - Тест базовой инициализации
    func testQuestionInitialization() {
        // Подготовка тестовых данных
        let hint = Hint(text: "Hint text", link: "https://example.com")
        let question = Question(
            text: "What is Git?",
            answers: ["VCS", "DB", "OS"],
            correctAnswerIndex: 0,
            hint: hint,
            category: "Git Basics",
            codeExample: "git init"
        )
        
        // Проверка значений
        XCTAssertEqual(question.text, "What is Git?")
        XCTAssertEqual(question.answers, ["VCS", "DB", "OS"])
        XCTAssertEqual(question.correctAnswerIndex, 0)
        XCTAssertEqual(question.hint.text, "Hint text")
        XCTAssertEqual(question.hint.link, "https://example.com")
        XCTAssertEqual(question.category, "Git Basics")
        XCTAssertEqual(question.codeExample, "git init")
        XCTAssertFalse(question.id.isEmpty, "ID должен генерироваться автоматически")
    }
    
    // MARK: - Тест инициализации из словаря (Firestore)
    func testFirestoreInitialization() {
        // Подготовка данных в формате Firestore
        let firestoreData: [String: Any] = [
            "text": "What is a commit?",
            "answers": ["Save", "Delete", "Update"],
            "correctAnswerIndex": 0,
            "hint": [
                "text": "Commit hint",
                "link": "https://commit.com"
            ] as [String: Any],
            "category": "Basics",
            "codeExample": "git commit"
        ]
        
        // Инициализация вопроса через метод для тестирования
        let question = createQuestionFromFirestoreData(
            data: firestoreData,
            documentID: "DOC123"
        )
        
        // Проверка корректности преобразования
        XCTAssertNotNil(question)
        XCTAssertEqual(question?.text, "What is a commit?")
        XCTAssertEqual(question?.id, "DOC123")
        XCTAssertEqual(question?.hint.text, "Commit hint")
        XCTAssertEqual(question?.hint.link, "https://commit.com")
        XCTAssertEqual(question?.category, "Basics")
        XCTAssertEqual(question?.codeExample, "git commit")
    }
    
    // MARK: - Тест обработки ошибок в данных
    func testInvalidFirestoreData() {
        // Создаем неполные данные (без обязательного поля "text")
        let invalidData: [String: Any] = [
            "answers": ["A", "B"],
            "correctAnswerIndex": 0,
            "hint": ["text": "Hint", "link": "link"],
            "category": "Test"
        ]
        
        let question = createQuestionFromFirestoreData(
            data: invalidData,
            documentID: "DOC123"
        )
        
        XCTAssertNil(question, "Инициализация должна вернуть nil при невалидных данных")
    }
    
    // MARK: - Тест граничных случаев
    func testAnswerIndexBoundaries() {
        let hint = Hint(text: "Test", link: "test.com")
        
        // Индекс за пределами массива
        let question = Question(
            text: "Test",
            answers: ["A", "B"],
            correctAnswerIndex: 5, // Невалидный индекс
            hint: hint,
            category: "Test"
        )
        
        // Проверяем обработку невалидного индекса
        XCTAssertEqual(question.correctAnswerIndex, 5, "Модель должна сохранять любой индекс")
    }
    
    // MARK: - Тест кодирования/декодирования (Codable)
    func testQuestionCodable() throws {
        // Создаем тестовый вопрос
        let originalQuestion = Question(
            text: "What is a branch?",
            answers: ["Feature", "Bug", "Main"],
            correctAnswerIndex: 2,
            hint: Hint(text: "Branch hint", link: "https://branch.com"),
            category: "Git",
            codeExample: "git branch"
        )
        
        // Кодируем в JSON
        let encoder = JSONEncoder()
        let data = try encoder.encode(originalQuestion)
        
        // Декодируем обратно
        let decoder = JSONDecoder()
        let decodedQuestion = try decoder.decode(Question.self, from: data)
        
        // Проверяем соответствие
        XCTAssertEqual(originalQuestion.id, decodedQuestion.id)
        XCTAssertEqual(originalQuestion.text, decodedQuestion.text)
        XCTAssertEqual(originalQuestion.answers, decodedQuestion.answers)
        XCTAssertEqual(originalQuestion.correctAnswerIndex, decodedQuestion.correctAnswerIndex)
        XCTAssertEqual(originalQuestion.hint.text, decodedQuestion.hint.text)
        XCTAssertEqual(originalQuestion.category, decodedQuestion.category)
        XCTAssertEqual(originalQuestion.codeExample, decodedQuestion.codeExample)
    }
    
    // MARK: - Вспомогательный метод для тестирования Firestore
    private func createQuestionFromFirestoreData(data: [String: Any], documentID: String) -> Question? {
        // Этот метод имитирует логику из init?(snap: QueryDocumentSnapshot)
        guard let text = data["text"] as? String,
              let answersArray = data["answers"] as? [String],
              let correctAnswerIndex = data["correctAnswerIndex"] as? Int,
              let hintDict = data["hint"] as? [String: Any],
              let categoryText = data["category"] as? String,
              let hintText = hintDict["text"] as? String,
              let hintLink = hintDict["link"] as? String else {
            return nil
        }
        
        // Обработка опционального поля
        let codeExample = data["codeExample"] as? String
        
        // Создаем объект Hint
        let hint = Hint(text: hintText, link: hintLink)
        
        // Создаем и возвращаем вопрос
        return Question(
            id: documentID,
            text: text,
            answers: answersArray,
            correctAnswerIndex: correctAnswerIndex,
            hint: hint,
            category: categoryText,
            codeExample: codeExample
        )
    }
}
