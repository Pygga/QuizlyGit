//
//  LeaderboardUser.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 08.05.2025.
//
import Foundation

// MARK: - Модели данных
struct LeaderboardUser: Identifiable {
    let id: String
    let name: String
    let avatarURL: URL?
    let totalScore: Int
    let rank: GitRank
    var position: Int = 0
}
