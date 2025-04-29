//
//  Profile.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import Foundation

class Profile: Identifiable{
    let id: String
    let name: String
    let email: String
    let score: Int
    
    
    init(id: String, name: String, email: String, score: Int) {
        self.id = id
        self.name = name
        self.email = email
        self.score = score
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
        
        return representation
    }
}
