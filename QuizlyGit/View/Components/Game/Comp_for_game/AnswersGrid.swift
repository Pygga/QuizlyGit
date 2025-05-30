//
//  AnswersGrid.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 25.05.2025.
//
import SwiftUI

struct AnswersGrid: View {
    let question: ShuffledQuestion
    @Binding var selectedIndex: Int?
    let onSelect: (Int) -> Void
    @State private var shuffledAnswers: [String]
    @EnvironmentObject var localization: LocalizationManager
    
    init(question: ShuffledQuestion, selectedIndex: Binding<Int?>, onSelect: @escaping (Int) -> Void) {
        self.question = question
        self._selectedIndex = selectedIndex
        self.onSelect = onSelect
        self.shuffledAnswers = question.answers.shuffled()
    }
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
            ForEach(Array(question.answers.enumerated()), id: \.offset) { index, answer in
                AnswerCard(
                    text: answer,
                    isSelected: selectedIndex == index,
                    isCorrect: index == question.correctAnswerIndex,
                    isRevealed: selectedIndex != nil
                ) {
                    handleSelection(at: index)
                }
            }
        }
    }
    
    private func isCorrectAnswer(_ index: Int) -> Bool {
        guard let originalIndex = question.answers.firstIndex(of: question.answers[index]) else {
            return false
        }
        return originalIndex == selectedIndex
    }
    
    private func handleSelection(at index: Int) {
        guard selectedIndex == nil else { return }
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedIndex = index
            onSelect(index)
        }
    }
}
