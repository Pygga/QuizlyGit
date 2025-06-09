//
//  StatCard.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 07.05.2025.
//
import SwiftUI

// MARK: - Вспомогательные компоненты
struct StatCard: View {
    let title: String
    let value: String
    @EnvironmentObject var localization: LocalizationManager

    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title3.bold())
            Text(LocalizedStringKey(title))
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(.colorBG)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 5)
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
    
}

struct LegendBadge: View {
    let color: Color
    let title: String
    let count: Int
    @EnvironmentObject var localization: LocalizationManager

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            
            VStack(alignment: .leading) {
                Text(LocalizedStringKey(title))
                    .font(.caption)
                Text("\(count)")
                    .font(.subheadline.bold())
            }
        }
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}
