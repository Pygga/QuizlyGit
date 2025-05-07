//
//  UserStatistics.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 06.05.2025.
//
import Foundation

// MARK: - Модель статистики
struct UserStatistics {
    var totalPlayTime: Int = 0
    var fastestQuiz: Int = 0
    var slowestQuiz: Int = 0
    var gamesPlayed: Int = 0
    var questionsAnswered: Int = 0
    var correctAnswers: Int = 0
    var totalScore: Int = 0
    var hintsUsed: Int = 0
    var incorrectAnswers: Int = 0
}

extension UserStatistics {
    init?(representation: [String: Any]) {
        guard let totalPlayTime = representation["totalPlayTime"] as? Int,
              let fastestQuiz = representation["fastestQuiz"] as? Int,
              let slowestQuiz = representation["slowestQuiz"] as? Int,
              let gamesPlayed = representation["gamesPlayed"] as? Int,
              let questionsAnswered = representation["questionsAnswered"] as? Int,
              let totalScore = representation["totalScore"] as? Int,
              let hintsUsed = representation["hintsUsed"] as? Int,
              let correctAnswers = representation["correctAnswers"] as? Int,
              let incorrectAnswers = representation["incorrectAnswers"] as? Int else {
            return nil
        }
        
        self.totalPlayTime = totalPlayTime
        self.fastestQuiz = fastestQuiz
        self.slowestQuiz = slowestQuiz
        self.gamesPlayed = gamesPlayed
        self.questionsAnswered = questionsAnswered
        self.totalScore = totalScore
        self.hintsUsed = hintsUsed
        self.correctAnswers = correctAnswers
        self.incorrectAnswers = incorrectAnswers
    }
    
    var representation: [String: Any] {
        return [
            "totalPlayTime": totalPlayTime,
            "fastestQuiz": fastestQuiz,
            "slowestQuiz": slowestQuiz,
            "gamesPlayed": gamesPlayed,
            "questionsAnswered": questionsAnswered,
            "totalScore": totalScore,
            "correctAnswers": correctAnswers,
            "incorrectAnswers": incorrectAnswers,
            "hintsUsed": hintsUsed
        ]
    }
}
