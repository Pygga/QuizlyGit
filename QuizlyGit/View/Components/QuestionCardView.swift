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
        VStack(alignment: .leading, spacing: 20) {
            // Карточка с вопросом
            VStack(alignment: .leading) {
                Text("Вопрос")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(question.text)
                    .font(.system(size: 18, weight: .medium))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            // Список ответов
            VStack(spacing: 12) {
                ForEach(question.answers.indices.shuffled(), id: \.self) { index in
                    AnswerButtonView(
                        text: question.answers[index],
                        isCorrect: isCorrectAnswer(index),
                        isSelected: selectedAnswerIndex == index,
                        isDisabled: selectedAnswerIndex != nil
                    ) {
                        handleAnswerSelection(at: index)
                    }
                }
            }
        }
        .padding()
    }
    
    private func isCorrectAnswer(_ index: Int) -> Bool {
        guard let originalIndex = question.answers.firstIndex(of: question.answers[index]) else {
            return false
        }
        return originalIndex == question.correctAnswerIndex
    }
    
    private func handleAnswerSelection(at index: Int) {
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedAnswerIndex = index
            onAnswerSelected(index)
        }
    }
}
//
//#Preview {
//    QuestionCardView()
//}
