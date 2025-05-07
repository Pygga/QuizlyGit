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
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title3.bold())
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.05), radius: 3)
    }
}

struct LegendBadge: View {
    let color: Color
    let title: String
    let count: Int
    
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                Text("\(count)")
                    .font(.subheadline.bold())
            }
        }
    }
}
