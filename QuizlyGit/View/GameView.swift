//
//  GameView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 01.05.2025.
//
import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    let onExit: () -> Void
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var localization: LocalizationManager
    @State private var showExitConfirmation = false
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            mainContent
                .alert("Выход из теста", isPresented: $showExitConfirmation) {
                    Button("Отмена", role: .cancel) {}
                    Button("Выйти", role: .destructive) { dismiss() }
                } message: {
                    Text("Весь прогресс будет потерян. Вы уверены?")
                }
            
            hintOverlay
        }
    }
    
    private var gameContent: some View {
        VStack {
            HStack {
                // Кнопка выхода слева
                Button(action: { showExitConfirmation = true }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(10)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                }
                .padding(.leading, 16)
                
                Spacer()
                
                // Прогресс-бар
                ProgressCounter(
                    current: viewModel.currentQuestionIndex + 1,
                    total: viewModel.questions.count
                )
                .padding(.trailing, 16)
                
                Spacer()
                
                // Таймер
                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .font(.caption)
                    
                    Text("\(viewModel.timeRemaining)s")
                        .font(.system(.callout, design: .monospaced))
                }
                .foregroundColor(.secondary)
                .padding(.trailing, 10)
            }
            .padding(.vertical, 12)
            // Карточка вопроса
            QuestionCard(question: viewModel.currentQuestion)
                .padding(.horizontal)
                .padding(.vertical, 8)
            
            // Карточки ответов
            AnswersGrid(
                question: viewModel.currentQuestion,
                selectedIndex: $viewModel.selectedAnswerIndex,
                onSelect: viewModel.selectAnswer
            ).id(viewModel.currentQuestion.id) // Принудительное обновление
            .padding(.horizontal)
            
            Spacer()
            // Нижняя панель
            HStack {
                HintButton(usedCount: viewModel.usedHints) {
                    viewModel.showHint = true
                    if viewModel.isFirstTap {
                        viewModel.usedHints = viewModel.usedHints + 1
                        viewModel.isFirstTap = false
                    }
                }
                
                Spacer()
                
                NextButton(isEnabled: viewModel.selectedAnswerIndex != nil) {
                    viewModel.moveToNextQuestion()
                    viewModel.isFirstTap = true
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .environment(\.locale, .init(identifier: localization.currentLanguage))
        .padding(.top, 24)
    }
    
    private var loadingView: some View {
        ProgressView("Загрузка вопросов...")
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.secondary)
    }
    
    @ViewBuilder
    private var mainContent: some View {
        switch viewModel.gameState {
        case .loading:
            loadingView
        case .inProgress:
            gameContent
        case .finished(let results):
            resultsView(results: results)
        case .error(let message):
            errorView(message: message)
        }
    }
    
    @ViewBuilder
    private var hintOverlay: some View {
        if viewModel.showHint {
            HintView(
                hint: viewModel.currentQuestion.hint,
                isPresented: $viewModel.showHint
            )
            .environment(\.locale, .init(identifier: localization.currentLanguage))
            .zIndex(1)
        }
    }
    
    private func resultsView(results: GameResults) -> some View {
        ResultsView(results: results)
            .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
    
    private func errorView(message: String) -> some View {
        ErrorView(message: message)
            .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}
