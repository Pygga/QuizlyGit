//
//  QuestionService.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 30.04.2025.
//

import Foundation
import FirebaseFirestore

//class QuestionService {
//    static let shared = QuestionService()
//    
//    func fetchQuestions(forCategory category: [String]) async throws -> [Question] {
//        let query = Firestore.firestore()
//            .collection("questions")
//            .whereField("category",in: category.isEmpty ? ["Git Basics"] : category)
//            .limit(to: 10) // Ограничение для теста
//        
//        let snapshot = try await query.getDocuments()
//        return snapshot.documents.compactMap { Question.init(snap: $0) }
//    }
//}
