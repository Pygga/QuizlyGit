//
//  NextButton.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 25.05.2025.
//
import SwiftUI

struct NextButton: View {
    let isEnabled: Bool
    let action: () -> Void
    @EnvironmentObject var localization: LocalizationManager
    var body: some View {
        Button(action: action) {
            Text("Далее")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(isEnabled ? .white : .gray)
                .padding(.vertical, 12)
                .padding(.horizontal, 32)
                .background(isEnabled ? Color.blue : Color(.systemGray5))
                .cornerRadius(8)
        }
        .disabled(!isEnabled)
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}
