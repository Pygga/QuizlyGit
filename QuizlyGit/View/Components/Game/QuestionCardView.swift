//
//  QuestionCardView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 30.04.2025.
//

import SwiftUI

struct QuestionCardView: View {
    let question: Question
    @State private var shuffledAnswers: [String]
    @Binding var selectedAnswerIndex: Int?
    let onAnswerSelected: (Int) -> Void
    
    init(question: Question, selectedAnswerIndex: Binding<Int?>, onAnswerSelected: @escaping (Int) -> Void) {
        self.question = question
        self._selectedAnswerIndex = selectedAnswerIndex
        self.onAnswerSelected = onAnswerSelected
        
        // Перемешиваем ответы при инициализации
        let shuffled = self.question.answers.shuffled()
        self.shuffledAnswers = shuffled
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Карточка с вопросом
//            VStack(alignment: .leading) {
//                Text("Вопрос")
//                    .font(.caption)
//                    .foregroundColor(.gray)
                
                Text(question.text)
                    .font(.system(size: 20, weight: .semibold))
                    .lineSpacing(6)
                    .padding(.horizontal, 24)
//            }
//            .padding()
//            .frame(maxWidth: .infinity)
//            .background(Color(UIColor.secondarySystemBackground))
//            .cornerRadius(12)
//            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            // Список ответов
            VStack(spacing: 12) {
                ForEach(question.answers.indices.shuffled(), id: \.self) { index in
                    AnswerButtonView(
                        text: question.answers[index],
                        isCorrect: isCorrectAnswer(index),
                        isSelected: selectedAnswerIndex == index,
                        isDisabled: selectedAnswerIndex != nil
                    ) {
                        handleSelection(at: index)
                    }
//                    AnswersButton(
//                        text: question.answers[index],
//                        isSelected: selectedAnswerIndex == index,
//                        isCorrect: isCorrectAnswer(index),
//                        isRevealed: selectedAnswerIndex != nil
//                    ) {
//                        handleSelection(at: index)
//                    }
                }
            }
//            .padding()
            .padding(.horizontal, 16)
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .padding()
    }
    
    private func isCorrectAnswer(_ index: Int) -> Bool {
        guard let originalIndex = question.answers.firstIndex(of: question.answers[index]) else {
            return false
        }
        return originalIndex == question.correctAnswerIndex
    }
    
    private func handleSelection(at index: Int) {
        guard selectedAnswerIndex == nil else { return }
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedAnswerIndex = index
            onAnswerSelected(index)
        }
    }
}

struct AnswersButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isRevealed: Bool
    let action: () -> Void
    
    private var backgroundColor: Color {
        if isSelected {
            return isCorrect ? .green.opacity(0.1) : .red.opacity(0.1)
        }
        return Color(.secondarySystemBackground)
    }
    
    private var borderColor: Color {
        if isRevealed {
            return isCorrect ? .green : .red
        }
        return isSelected ? .blue : .clear
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.system(size: 16))
                    .foregroundColor(isSelected ? .primary : .secondary)
                
                if isSelected {
                    Spacer()
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(isCorrect ? .green : .red)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(backgroundColor)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(borderColor, lineWidth: 1)
            )
        }
        .disabled(isRevealed)
    }
}
//
//#Preview {
//    QuestionCardView()
//}
