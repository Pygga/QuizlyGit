//
//  StatisticsView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//

import SwiftUI

// MARK: - Экран статистики
struct StatisticsView: View {
    @StateObject private var viewModel = StatisticsViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Текущий ранг
                RankCardView(viewModel: viewModel)
                
                // Основные метрики
                StatsGrid(viewModel: viewModel)
                
                // Визуализация ответов
                AnswersPieChart(viewModel: viewModel)
                
                // Детальная статистика
                DetailedStatsView(viewModel: viewModel)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Моя статистика")
        .onAppear { viewModel.loadData() }
    }
}

// MARK: - Компоненты

private struct RankCardView: View {
    @ObservedObject var viewModel: StatisticsViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Text(viewModel.currentRank.rawValue)
                .font(.title2.bold())
            
            ProgressView(value: viewModel.rankProgress)
//                .progressViewStyle(
//                    .linearCapacity(
//                        trackColor: .gray.opacity(0.3),
//                        progressColor: .blue
//                    )
//                )
                .frame(height: 8)
            
            if let nextRank = viewModel.currentRank.nextRank {
                Text("До \(nextRank.rawValue): \(viewModel.pointsToNextRank) очков")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5)
    }
}

struct StatsGrid: View {
    @ObservedObject var viewModel: StatisticsViewModel
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            StatCard(title: "Игр сыграно", value: "\(viewModel.stats.gamesPlayed)")
            StatCard(title: "Общий счёт", value: "\(viewModel.stats.totalScore)")
            StatCard(title: "Правильных ответов", value: "\(viewModel.stats.correctAnswers)")
            StatCard(title: "Среднее время", value: "\(viewModel.averageTimePerGame)s")
        }
    }
}

private struct AnswersPieChart: View {
    @ObservedObject var viewModel: StatisticsViewModel
    private let size: CGFloat = 180
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .strokeBorder(Color.gray.opacity(0.2), lineWidth: 20)
                
                Circle()
                    .trim(from: 0, to: viewModel.correctAnswersRatio)
                    .stroke(Color.green, lineWidth: 20)
                    .rotationEffect(.degrees(-90))
                
                Circle()
                    .trim(from: viewModel.correctAnswersRatio, to: 1.0)
                    .stroke(Color.red, lineWidth: 20)
                    .rotationEffect(.degrees(-90))
                
                VStack {
                    Text("\(Int(viewModel.correctAnswersRatio * 100))%")
                        .font(.title.bold())
                    Text("правильно")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: size, height: size)
            
            HStack(spacing: 20) {
                LegendBadge(color: .green, title: "Правильные", count: viewModel.stats.correctAnswers)
                LegendBadge(color: .red, title: "Ошибки", count: viewModel.stats.questionsAnswered - viewModel.stats.correctAnswers)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5)
    }
}

#Preview {
    StatisticsView()
}
