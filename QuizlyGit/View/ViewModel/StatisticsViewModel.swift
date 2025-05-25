//
//  StatisticsViewModel.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 07.05.2025.
//
import Foundation
import FirebaseAuth

class StatisticsViewModel: ObservableObject {
    @Published var stats = UserStatistics()
    @Published var currentRank: GitRank = .newcomer
    @Published var rankProgress: Double = 0
    @Published var isLoading = false
    
    private let firestoreService = FirestoreService.shared
    
    var pointsToNextRank: Int {
        max((currentRank.nextRank?.requiredScore ?? currentRank.requiredScore) - stats.totalScore, 0)
    }
    
    var correctAnswersRatio: Double {
        guard stats.questionsAnswered > 0 else { return 0 }
        return Double(stats.correctAnswers) / Double(stats.questionsAnswered)
    }
    
    var averageTimePerGame: Int {
        guard stats.gamesPlayed > 0 else { return 0 }
        return stats.totalPlayTime / stats.gamesPlayed
    }
    
    func loadData() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        isLoading = true
        Task {
            do {
                let loadedStats = try await firestoreService.getStatistics(userId: userId)
                await MainActor.run {
                    self.stats = loadedStats
                    self.calculateRank()
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.isLoading = false
                }
                print("Ошибка загрузки статистики: \(error)")
            }
        }
    }
    
    private func calculateRank() {
        let allRanks = GitRank.allCases
        guard !allRanks.isEmpty else { return }
        
        for rank in allRanks.reversed() {
            if stats.totalScore >= rank.requiredScore {
                currentRank = rank
                break
            }
        }
        
        guard let nextRank = currentRank.nextRank else {
            rankProgress = 1.0
            return
        }
        
        let current = currentRank.requiredScore
        let next = nextRank.requiredScore
        rankProgress = Double(stats.totalScore - current) / Double(next - current)
    }
}
