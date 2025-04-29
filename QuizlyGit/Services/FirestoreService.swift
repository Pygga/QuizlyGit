//
//  FirestoreService.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import Foundation
import FirebaseFirestore

actor FirestoreService{
    static let shared = FirestoreService(); private init() {}
    
    let db = Firestore.firestore()
    var profiles: CollectionReference {
        db.collection("profiles")
    }
    
    func createProfile(_ profile: Profile) async throws -> Profile{
        try await profiles.document(profile.id).setData(profile.representation)
        return profile
    }
    
    func getProfile(_ id: String) async throws -> Profile{
        let snapshot = try await profiles.document(id).getDocument()
        
        guard let representation = snapshot.data() else {
            throw DataBaseError.dataNotFound
        }
        
        guard let profile = Profile(representation: representation) else {
            throw DataBaseError.wrongData
        }
        return profile
    }
}

enum DataBaseError: Error{
    case dataNotFound
    case wrongData
}
