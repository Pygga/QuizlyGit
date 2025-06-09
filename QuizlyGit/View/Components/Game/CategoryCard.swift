//
//  CategoryCard.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 30.05.2025.
//
import SwiftUI

// Карточка категории
struct CategoryCard: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .frame(width: 48, height: 48)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .multilineTextAlignment(.center)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(.themeBG)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
        }
        .buttonStyle(ScaleStyle())
    }
}
