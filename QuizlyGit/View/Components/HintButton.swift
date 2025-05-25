//
//  HintButton.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 25.05.2025.
//
import SwiftUI

struct HintButton: View {
    let usedCount: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "lightbulb")
                    .font(.system(size: 14, weight: .bold))
                
                Text("\(usedCount)")
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(.secondary)
            .padding(10)
            .background(Color(.systemGray5))
            .cornerRadius(6)
        }
    }
}
