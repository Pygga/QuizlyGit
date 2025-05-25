//
//  ScaleButtonStyle.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 25.05.2025.
//
import SwiftUI

// Стиль для анимации нажатия
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 0.9)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
