//
//  StatisticsManager.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 07.05.2025.
//
import Foundation
import FirebaseAuth

class StatisticsManager {
    static let shared = StatisticsManager()
    private let firestoreService = FirestoreService.shared
    
    func saveGameResults(_ results: GameResults) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Task {
            do {
                var stats = try await firestoreService.getStatistics(userId: userId)
                
                stats.gamesPlayed += 1
                stats.totalPlayTime += results.totalTime
                stats.questionsAnswered += results.totalQuestions
                stats.correctAnswers += results.correctAnswers
                stats.incorrectAnswers += results.incorrectAnswers
                stats.hintsUsed += results.usedHints
                stats.totalScore += results.finalScore
                
                if results.totalTime < stats.fastestQuiz || stats.fastestQuiz == 0 {
                    stats.fastestQuiz = results.totalTime
                }
                
                if results.totalTime > stats.slowestQuiz {
                    stats.slowestQuiz = results.totalTime
                }
                
                try await firestoreService.updateStatistics(userId: userId, stats: stats)
                
                // Добавьте проверку достижений после сохранения статистики
                DispatchQueue.global(qos: .background).async {
                    let unlocked = AchievementManager.shared.checkAchievements(stats: stats)
                    
//                    if !unlocked.isEmpty {
//                        DispatchQueue.main.async {
//                            self.showAchievementNotification(unlocked)
//                        }
//                    }
                }
            } catch {
                print("Ошибка сохранения статистики: \(error)")
            }
        }
    }
}
