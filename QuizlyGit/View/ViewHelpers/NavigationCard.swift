//
//  NavigationCard.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 25.05.2025.
//
import SwiftUI
import Foundation

struct NavigationCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: LinearGradient
    let action: () -> Void
    
    @EnvironmentObject var localization: LocalizationManager
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background(
                        Circle()
                            .fill(color)
                            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
                    )
                    .foregroundColor(.white)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(LocalizedStringKey(title))
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primaryText)
                    
                    Text(LocalizedStringKey(subtitle))
                        .font(.system(size: 14))
                        .foregroundColor(.secondaryText)
                }
                
                Spacer()
                
                Image(systemName: "chevron.forward")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 20))
            }
            .frame(height: 120)
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.cardBackground)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
                
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.cardBorder, lineWidth: 1)
            )
            .scaleEffect(isPressed ? 0.98 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
            
        }
        .buttonStyle(MorphButtonStyle(isPressed: $isPressed))
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}
