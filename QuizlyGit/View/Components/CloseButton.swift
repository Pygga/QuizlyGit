//
//  CloseButton.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 25.05.2025.
//
import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .font(.system(size: 14, weight: .bold))
                .padding(8)
                .background(Color(.systemGray5))
                .clipShape(Circle())
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
