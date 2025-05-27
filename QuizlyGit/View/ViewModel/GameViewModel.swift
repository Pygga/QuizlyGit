//
//  GameViewModel.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 01.05.2025.
//

import Foundation
import Combine
import FirebaseFirestore

class GameViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var timeRemaining: Int = 30
    @Published var selectedAnswerIndex: Int?
    @Published var showHint: Bool = false
    @Published var gameState: GameState = .loading
    @Published var totalScore: Int = 0
    @Published var usedHints: Int = 0
    @Published var correctAnswers: Int = 0
    @Published var incorrectAnswers: Int = 0
    @Published var isFirstTap: Bool = true
    private let questionStorage = QuestionStorage.shared //
    // MARK: - Game Configuration
    private var config: QuizConfig
    private var timer: AnyCancellable?
    private var startDate: Date?
    // MARK: - Initialization
    init(config: QuizConfig) {
        print("Создана игра с конфигом:", config)
        self.config = config
        startGame()
    }
    
    // MARK: - Game Lifecycle
    private func startGame() {
        gameState = .loading
        loadQuestions()
    }
    private func loadQuestions() { //
            let filteredQuestions = questionStorage.allQuestions
                .filter { !config.categories.isEmpty || config.categories.contains($0.category) }
                .shuffled()
                .prefix(config.questionsCount)
            

                if filteredQuestions.isEmpty {
                    gameState = .error(message: "Нет вопросов по выбранным категориям")
                } else {
                    setupGame(with: Array(filteredQuestions))
                }
            
        }
    private func setupGame(with questions: [Question]) {
        self.questions = questions
        self.timeRemaining = config.timePerQuestion // Используем настройку времени
        startTimer()
        gameState = .inProgress
        startDate = Date()
    }
    
    // MARK: - Timer Management
    private func startTimer() {
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateTimer()
            }
    }
    
    private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            handleTimeExpired()
        }
    }
    
    // MARK: - Answer Handling
    func selectAnswer(at index: Int) {
        guard selectedAnswerIndex != nil else { return }
        
        selectedAnswerIndex = index
        timer?.cancel()
        calculateScore()
        
        if shouldShowHint {
            showHint = true
            usedHints += 1
        }
        
        if isAnswerCorrect(index) {
            correctAnswers += 1
        } else {
            incorrectAnswers += 1
            if config.stopOnWrongAnswer {
                endGame()
            }
        }
    }
    
    private var shouldShowHint: Bool {
        guard let selected = selectedAnswerIndex else { return false }
        return !isAnswerCorrect(selected) && config.showHints
    }
    
    private func isAnswerCorrect(_ index: Int) -> Bool {
        if questions[currentQuestionIndex].correctAnswerIndex == index{
            print(questions[currentQuestionIndex])
            return true
        } else {
            return false
        }
    }
    
    // MARK: - Score Calculation
    private func calculateScore() {
        guard let selected = selectedAnswerIndex,
              isAnswerCorrect(selected) else {
            return
        }
        
        let baseScore = 100
        let remainingTime = timeRemaining
        let calculatedScore = max(10, (Int(Double(baseScore) * (Double(remainingTime)/30.0))))
        
        totalScore += calculatedScore
    }
    
    // MARK: - Navigation
    func moveToNextQuestion() {
        guard currentQuestionIndex < questions.count - 1 else {
            endGame()
            return
        }
        
        resetForNextQuestion()
    }
    
    private func resetForNextQuestion() {
        currentQuestionIndex += 1
        timeRemaining = config.timePerQuestion
        selectedAnswerIndex = nil
        showHint = false
        startTimer()
    }
    
    private func handleTimeExpired() {
        timer?.cancel()
        selectedAnswerIndex = -1 // Специальное значение для обозначения истечения времени
        moveToNextQuestion()
        isFirstTap = true
    }
    
    // MARK: - Game Completion
    private func endGame() {
        timer?.cancel()
        let results = GameResults(
            totalQuestions: questions.count,
            correctAnswers: self.correctAnswers,
            usedHints: usedHints,
            totalTime: totalGameTime(),
            finalScore: self.totalScore
        )
        
        gameState = .finished(results: results)
        config.stopOnWrongAnswer = false
        // Сохраняем конкретные результаты игры
        StatisticsManager.shared.saveGameResults(results)
    }
    
    private func totalGameTime() -> Int {
        Int(Date().timeIntervalSince(startDate ?? Date()))
    }
}

extension GameViewModel {
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }
}
