//
//  ResultRow.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 01.05.2025.
//

import SwiftUI

struct ResultRow: View {
    let title: String
    let value: String
    let systemImage: String
    let color: Color
    @EnvironmentObject var localization: LocalizationManager
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text(LocalizedStringKey(title))
                .font(.headline)
            
            Spacer()
            
            Text(value)
                .font(.system(.body, design: .monospaced))
                .bold()
        }
        .environment(\.locale, .init(identifier: localization.currentLanguage))
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}
