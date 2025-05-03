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
    
    struct GameResults {
        let totalQuestions: Int
        let correctAnswers: Int
        let usedHints: Int
        let totalTime: Int
        let finalScore: Int
    }
}
