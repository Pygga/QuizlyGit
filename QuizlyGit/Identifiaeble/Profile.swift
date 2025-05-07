//
//  Profile.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import Foundation

class Profile: Identifiable, Equatable{
    let id: String
    let name: String
    let email: String
    var score: Int
//    var lastSessionId: String?
    
    init(id: String, name: String, email: String, score: Int) {
        self.id = id
        self.name = name
        self.email = email
        self.score = score
    }
    
    // Реализация Equatable
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        lhs.id == rhs.id // Сравниваем по id, так как он уникален
    }
}

extension Profile{
    convenience init?(representation: [String : Any]){
        guard let id = representation["id"] as? String,
              let name = representation["name"] as? String,
              let email = representation["email"] as? String,
              let score = representation["score"] as? Int else {
            return nil
        }
        self.init(id: id, name: name, email: email, score: score)
    }
}

extension Profile{
    var representation: [String : Any]{
        var representation : [String: Any] = [:]
        
        representation["id"] = id
        representation["name"] = name
        representation["email"] = email
        representation["score"] = score
//        representation["lastSessionId"] = lastSessionId
        
        return representation
    }
}
