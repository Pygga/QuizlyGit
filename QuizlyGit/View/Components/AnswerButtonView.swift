//
//  AnswerButtonView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 30.04.2025.
//

import SwiftUI

struct AnswerButtonView: View {
    let text: String
    let isCorrect: Bool
    let isSelected: Bool
    let isDisabled: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if isSelected {
            return isCorrect ? .green : .red
        }
        return Color.blue.opacity(0.2)
    }
    
    var textColor: Color {
        isSelected ? .white : .primary
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(textColor)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if isSelected {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(.white)
                        .padding(.trailing)
                }
            }
            .background(backgroundColor)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
            )
            .scaleEffect(isSelected ? 1.02 : 1)
            .opacity(isDisabled && !isSelected ? 0.6 : 1)
        }
        .disabled(isDisabled)
        .buttonStyle(PlainButtonStyle())
    }
}
//
//#Preview {
//    AnswerButtonView(text: "", isCorrect: true, isSelected: false, isDisabled: true, action:)
//}
