//
//  Question.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 30.04.2025.
//

import Foundation
import FirebaseFirestore

class Question: Identifiable, Codable{
    var id: String
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int // 0
    let hint: Hint
    let category: String
    let codeExample: String?
    
    init(id: String = UUID().uuidString, text: String, answers: [String], correctAnswerIndex: Int, hint: Hint, category: String,
         codeExample: String? = nil
    ) {
        self.id = id
        self.text = text
        self.answers = answers
        self.correctAnswerIndex = correctAnswerIndex
        self.hint = hint
        self.category = category
        self.codeExample = codeExample
    }
    
    init?(snap: QueryDocumentSnapshot){
        let data = snap.data()
        guard let text = data["text"] as? String,
              let answersArray = data["answers"] as? [String],
              let correctAnswerIndex = data["correctAnswerIndex"] as? Int,
              let hintText = data["hint"] as? [String: Any],
              let categoryText = data["category"] as? String,
              let hintLink = hintText["link"] as? String,
              let hintTextValue = hintText["text"] as? String,
              let codeExample = data["codeExample"] as? String
        else {return nil}
        self.text = text
        self.answers = answersArray
        self.answers.indices.forEach { index in
            if index == correctAnswerIndex {
                print("Correct answer index: \(index)")
            }
        }
        self.correctAnswerIndex = correctAnswerIndex
        self.hint = Hint(text: hintTextValue, link: hintLink)
        self.id = snap.documentID
        self.category = categoryText
        self.codeExample = codeExample
    }
}

struct Hint: Codable {
    let text: String
    let link: String
}
