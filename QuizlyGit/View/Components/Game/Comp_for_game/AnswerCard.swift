//
//  AnswerCard.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 25.05.2025.
//
import SwiftUI

struct AnswerCard: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isRevealed: Bool
    let action: () -> Void
    @EnvironmentObject var localization: LocalizationManager
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.system(size: 14))
                    .foregroundColor(textColor)
                    .lineLimit(2)
                
                if isSelected {
                    Spacer()
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(iconColor)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 80)
            .background(backgroundColor)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )
        }
        .disabled(isRevealed)
    }
    
    private var textColor: Color {
        isSelected ? .primary : .secondary
    }
    
    private var iconColor: Color {
        isCorrect ? .green : .red
    }
    
    private var backgroundColor: Color {
        if isSelected {
            return isCorrect ? Color.green.opacity(0.1) : Color.red.opacity(0.1)
        }
        return .themeBG
    }
    
    private var borderColor: Color {
        if isRevealed {
            return isCorrect ? .green : .red
        }
        return isSelected ? .blue : Color(.systemGray5)
    }
}
