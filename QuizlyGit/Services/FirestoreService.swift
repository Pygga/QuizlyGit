//
//  FirestoreService.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
//Сервис для работы с бд
actor FirestoreService{
    static let shared = FirestoreService(); private init() {}
    
    let db = Firestore.firestore()
    var profiles: CollectionReference {
        db.collection("profiles")
    }  
    
    private func settingsRef(for userId: String) -> DocumentReference {
        db.collection("settings").document(userId)
    }
    
    private func statsRef(for userId: String) -> DocumentReference {
        db.collection("statistics").document(userId)
    }
    
    // MARK: - Настройки
    func getSettings(userId: String) async throws -> AppSettings {
        let snapshot = try await settingsRef(for: userId).getDocument()
        guard let data = snapshot.data() else {
            throw NSError(domain: "FirestoreError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Документ не найден"])
        }
        
        guard let settings = AppSettings(representation: data) else {
            throw NSError(domain: "FirestoreError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Ошибка парсинга данных"])
        }
        
        return settings
    }
    
    func updateSettings(userId: String, settings: AppSettings) async throws {
        try await settingsRef(for: userId).setData(settings.representation, merge: true)
        print("Отправляемые данные настроек: \(settings.representation)")
    }

    // MARK: - Статистика
    func getStatistics(userId: String) async throws -> UserStatistics {
        let snapshot = try await statsRef(for: userId).getDocument()
        guard let data = snapshot.data() else { return UserStatistics() }
        return UserStatistics(representation: data) ?? UserStatistics()
    }
    
    func updateStatistics(userId: String, stats: UserStatistics) async throws {
        try await statsRef(for: userId).setData(stats.representation, merge: true)
    }
    
    func updateGameStats(userId: String, time: Int, correctAnswers: Int, hintsUsed: Int) async {
        do {
            var stats = try await getStatistics(userId: userId)
            stats.gamesPlayed += 1
            stats.questionsAnswered += correctAnswers
            stats.hintsUsed += hintsUsed
            stats.totalPlayTime += time
            
            if time < stats.fastestQuiz || stats.fastestQuiz == 0 {
                stats.fastestQuiz = time
            }
            
            if time > stats.slowestQuiz {
                stats.slowestQuiz = time
            }
            
            try await updateStatistics(userId: userId, stats: stats)
        } catch {
            print("Error updating stats: \(error)")
        }
    }
    
    // MARK: - Профиль
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
    
    func updateProfile(_ profile: Profile) async throws {
        try await profiles.document(profile.id).updateData(profile.representation)
    }
    
    func uploadAvatar(imageData: Data, userId: String) async throws -> URL {
        let storageRef = Storage.storage().reference()
        let avatarRef = storageRef.child("avatars/\(userId).jpg")
        let _ = try await avatarRef.putDataAsync(imageData)
        return try await avatarRef.downloadURL()
    }
}

enum DataBaseError: Error{
    case dataNotFound
    case wrongData
}
