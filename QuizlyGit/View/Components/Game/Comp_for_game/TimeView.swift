//
//  TimeView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 25.05.2025.
//
import SwiftUI

struct TimeView: View {
    let time: Int
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "clock")
                .font(.system(size: 14, weight: .semibold))
            
            Text("\(time)")
                .font(.system(.body, design: .monospaced))
                .contentTransition(.numericText())
        }
        .foregroundColor(.secondary)
        .padding(8)
        .padding(.horizontal, 4)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
