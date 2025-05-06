//
//  GameView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 01.05.2025.
//
import SwiftUI

// Заглушка для GameView (реализацию игры нужно добавить отдельно)
struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var displayedTime: Int = 0
    var body: some View {
        ZStack{
            Group {
                switch viewModel.gameState {
                case .loading:
                    ProgressView("Загрузка вопросов...")
                    
                case .inProgress:
                    gameContent
                    
                case .finished(let results):
                    ResultsView(results: results)
                    
                case .error(let message):
                    ErrorView(message: message)
                }
                
                // Модальное окно подсказки
                if viewModel.showHint {
                    
                    HintView(
                        hint: viewModel.currentQuestion.hint,
                        isPresented: $viewModel.showHint
                    )
                    .zIndex(1)
                    
                    //                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }
    
    private var gameContent: some View {
        VStack {
            // Заголовок с прогрессом
            HStack {
                Text("Вопрос \(viewModel.currentQuestionIndex + 1)/\(viewModel.questions.count)")
                Spacer()

//                Text("\(viewModel.timeRemaining)s")
//                TimeView(time: viewModel.timeRemaining)
            }
            .padding()

                // Карточка вопроса
                QuestionCardView(
                    question: viewModel.questions[viewModel.currentQuestionIndex],
                    selectedAnswerIndex: $viewModel.selectedAnswerIndex,
                    onAnswerSelected: { index in
                        viewModel.selectAnswer(at: index)
                    }
                )
            
            
            // Кнопки управления
            HStack {
                Button(action: { viewModel.showHint = true }) {
                    HStack {
                        Image(systemName: "lightbulb")
                        Text("Подсказка (\(viewModel.usedHints))")
                    }
                    .padding(10)
                    .background(Color.orange.opacity(0.2))
                    .cornerRadius(8)
                }
                .disabled(viewModel.selectedAnswerIndex == nil || viewModel.showHint)
                
                Spacer()
                
                Button("Далее") {
                    viewModel.moveToNextQuestion()
                }
                .disabled(viewModel.selectedAnswerIndex == nil)
            }
            .padding()
        }
    }
}

struct TimeView: View {
    let time: Int
    
    var body: some View {
        Text("\(time)")
            .contentTransition(.numericText())
    }
}
