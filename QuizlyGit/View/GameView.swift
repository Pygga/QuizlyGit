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
        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea()
            Group {
                switch viewModel.gameState {
                    
                case .loading:
                    ProgressView("Загрузка вопросов...")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.secondary)
                    
                case .inProgress:
                    gameContent
                    
                case .finished(let results):
                    ResultsView(results: results)
                        .environment(\.locale, .init(identifier: localization.currentLanguage))
                    
                case .error(let message):
                    ErrorView(message: message)
                        .environment(\.locale, .init(identifier: localization.currentLanguage))
                }
                // Модальное окно подсказки
                if viewModel.showHint {
                    
                    HintView(
                        hint: viewModel.currentQuestion.hint,
                        isPresented: $viewModel.showHint
                    )
                    .environment(\.locale, .init(identifier: localization.currentLanguage))
                    .zIndex(1)
                }
            }
        
            .alert("Выход из теста", isPresented: $showExitConfirmation) {
                Button("Отмена", role: .cancel) {}
                Button("Выйти", role: .destructive) { dismiss() }
            } message: {
                Text("Весь прогресс будет потерян. Вы уверены?")
            }
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
                }
                
                Spacer()
                
                NextButton(isEnabled: viewModel.selectedAnswerIndex != nil) {
                    viewModel.moveToNextQuestion()
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .environment(\.locale, .init(identifier: localization.currentLanguage))
        .padding(.top, 24)
    }
}

// MARK: - Компоненты

struct QuestionCard: View {
    let question: Question
    @EnvironmentObject var localization: LocalizationManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Вопрос")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(question.text)
                .font(.system(size: 18, weight: .medium))
            
//            if let codeExample = question.codeExample {
//                CodeBlock(text: codeExample)
//            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}

struct CodeBlock: View {
    let text: String
    
    var body: some View {
        VStack {
            HStack {
                Text(text)
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
        .background(Color.black)
        .cornerRadius(8)
    }
}
