//
//  CategoryButtonView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//
import SwiftUI

struct CategoryButtonView: View {
    let category: Category
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: category.iconName)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .white : category.color)
                
                Text(category.name)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(isSelected ? .white : .primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .padding(16)
            .frame(width: 100, height: 100)
            .background{
                Circle()
                    .fill(isSelected ? category.color.opacity(0.9) : category.color.opacity(0.2))
                    .overlay(
                        Circle()
                            .stroke(isSelected ? category.color : Color.clear, lineWidth: 2)
                    )
            }
            .buttonStyle(ScaleButtonStyle())
        }
    }
}
// 4. Стиль для анимации нажатия
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 0.9)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
