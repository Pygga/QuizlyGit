//
//  View+Extensions.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import SwiftUI


extension View{
//    @ViewBuilder
//    func hSpacing(_ aligment: Alignment = .center) -> some View{
//        self
//            .frame(maxWidth: .infinity,alignment: aligment)
//    }
//    
//    @ViewBuilder
//    func vSpacing(_ aligment: Alignment = .center) -> some View{
//        self
//            .frame(maxHeight: .infinity,alignment: aligment)
//    }
    
    @available(iOSApplicationExtension, unavailable)
    var safeArea: UIEdgeInsets {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene){
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        return .zero
    }
}


// MARK: - Supporting Types
extension GameViewModel {
    enum GameState {
        case loading
        case inProgress
        case finished(results: GameResults)
        case error(message: String)
    }
}

struct GameResults {
    let totalQuestions: Int
    let correctAnswers: Int
    let usedHints: Int
    let totalTime: Int
    let finalScore: Int
}

extension GameResults {
    var incorrectAnswers: Int {
        totalQuestions - correctAnswers
    }
}

// MARK: - Цветовая схема
extension Color {
    static let background = Color(.systemBackground)
    static let secondaryBackground = Color(.secondarySystemBackground)
    static let primaryText = Color(.label)
    static let secondaryText = Color(.secondaryLabel)
    static let cardBackground = Color(.tertiarySystemBackground)
    static let cardBorder = Color(.separator).opacity(0.3)
    static let accentColor = Color.gitOrange
    
    static let blueGradient = LinearGradient(
        colors: [
            Color(.sRGB, red: 0.3686, green: 0.5059, blue: 0.9569),
            Color(.sRGB, red: 0.2510, green: 0.4039, blue: 0.8392)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let greenGradient = LinearGradient(
        colors: [
            Color(.sRGB, red: 0.4275, green: 0.8392, blue: 0.6275),
            Color(.sRGB, red: 0.2941, green: 0.7490, blue: 0.5255)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let redGradient = LinearGradient(
        colors: [
            Color(.sRGB, red: 1.0000, green: 0.4824, blue: 0.4824),
            Color(.sRGB, red: 0.9020, green: 0.3529, blue: 0.3529)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

// Расширение для безопасного доступа к элементам массива
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

// Расширение для преобразования числа в порядковое строковое представление
extension Int {
    var ordinalString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension String {
    func ranges(of substring: String) -> [Range<String.Index>] {
        var ranges: [Range<String.Index>] = []
        var searchStartIndex = startIndex
        
        while let range = range(
            of: substring,
            options: .caseInsensitive,
            range: searchStartIndex..<endIndex
        ) {
            ranges.append(range)
            searchStartIndex = range.upperBound
        }
        return ranges
    }
}
