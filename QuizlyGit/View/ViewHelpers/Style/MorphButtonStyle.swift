//
//  MorphButtonStyle.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 25.05.2025.
//
import SwiftUI

struct MorphButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .brightness(configuration.isPressed ? -0.05 : 0)
            .onChange(of: configuration.isPressed) { newValue in
                isPressed = newValue
            }
    }
}
