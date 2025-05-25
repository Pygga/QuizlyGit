//
//  BackButton.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 20.05.2025.
//
import SwiftUI

struct BackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .font(.system(size: 14, weight: .semibold))
                .padding(8)
                .background(Color(.systemGray5))
                .clipShape(Circle())
        }
        .buttonStyle(ScaleStyle())
    }
}
