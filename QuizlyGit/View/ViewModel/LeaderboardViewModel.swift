//
//  LeaderboardViewModel.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 08.05.2025.
//
import Foundation
import FirebaseAuth

// MARK: - ViewModel
final class LeaderboardViewModel: ObservableObject {
    @Published var users: [LeaderboardUser] = []
    @Published var currentUserPosition: Int = 0
    @Published var isLoading = false
    @Published var error: Error?
    
    private let firestoreService = FirestoreService.shared
    
    func loadLeaderboard() {
        isLoading = true
        Task {
            do {
                // Создаем локальную копию данных
                let newUsers = try await fetchLeaderboardData()
                
                // Обновляем UI на главном потоке
                await MainActor.run { [newUsers] in
                    self.users = newUsers
                    self.findCurrentUserPosition()
                    self.isLoading = false
                }
                
            } catch {
                await MainActor.run {
                    self.error = error
                    self.isLoading = false
                }
            }
        }
    }
    
    private func fetchLeaderboardData() async throws -> [LeaderboardUser] {
        let statsSnapshot = try await firestoreService.db.collection("statistics")
            .order(by: "totalScore", descending: true)
            .limit(to: 100)
            .getDocuments()
        
        return try await withThrowingTaskGroup(of: LeaderboardUser.self) { group in
            for (index, document) in statsSnapshot.documents.enumerated() {
                group.addTask {
                    
                    // 1. Декодируем статистику
                    let stats = try document.data(as: UserStatistics.self)
                    
                    // 2. Получаем профиль пользователя
                    let userId = document.documentID
                    let profile = try await self.firestoreService.getProfile(userId)
                    
                    // 3. Рассчитываем ранг
                    let rank = self.calculateRank(for: stats.totalScore)
                    
                    // 4. Создаем объект для таблицы лидеров
                    return LeaderboardUser(
                        id: userId,
                        name: profile.name,
                        avatarURL: profile.avatarURL,
                        totalScore: stats.totalScore,
                        rank: rank,
                        position: index + 1
                    )
                }
            }
            
            var leaderboard = [LeaderboardUser]()
            for try await user in group {
                leaderboard.append(user)
            }
            // Сортируем по позициям на случай параллельной обработки
            return leaderboard.sorted { $0.position < $1.position }
        }
    }
    
    private func calculateRank(for score: Int) -> GitRank {
        GitRank.allCases.last { $0.requiredScore <= score } ?? .newcomer
    }
    
    private func findCurrentUserPosition() {
        guard let currentUserId = Auth.auth().currentUser?.uid,
              let currentUserIndex = users.firstIndex(where: { $0.id == currentUserId }) else {
            currentUserPosition = 0
            return
        }
        currentUserPosition = currentUserIndex + 1
    }
}
