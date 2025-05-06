//
//  QuestionStorage.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//
import Foundation
import FirebaseFirestore

// Сервис для загрузки и хранения вопросов
class QuestionStorage {
    static let shared = QuestionStorage()
    private init() {}
    
    private(set) var allQuestions: [Question] = []
    
    func loadQuestions() async throws {
        let snapshot = try await Firestore.firestore()
            .collection("questions")
            .getDocuments()
        
        return self.allQuestions = snapshot.documents.compactMap { Question.init(snap: $0) }
    }
}
