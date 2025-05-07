//
//  GitRank.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 07.05.2025.
//
import Foundation

// MARK: - Модель рангов Git
enum GitRank: String, CaseIterable {
    case newcomer = "🌱 Новичок"
    case contributor = "💡 Контрибьютор"
    case maintainer = "🛠️ Мейнтейнер"
    case architect = "📐 Архитектор"
    case maestro = "🎓 Маэстро"
    case legend = "🏆 Git-Легенда"
    
    var requiredScore: Int {
        switch self {
        case .newcomer: return 0
        case .contributor: return 1500
        case .maintainer: return 4000
        case .architect: return 10000
        case .maestro: return 25000
        case .legend: return 50000
        }
    }
    
    var nextRank: GitRank? {
        let all = GitRank.allCases
        guard let index = all.firstIndex(of: self) else { return nil }
        return index < all.count - 1 ? all[index + 1] : nil
    }
}
