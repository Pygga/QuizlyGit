//
//  QuestionCard.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 30.05.2025.
//
import SwiftUI

struct QuestionCard: View {
    let question: ShuffledQuestion
    @EnvironmentObject var localization: LocalizationManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Вопрос")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(question.original.text)
                .font(.system(size: 18, weight: .medium))
            
            if let codeExample = question.codeExample {
                CodeBlock(text: codeExample)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}
