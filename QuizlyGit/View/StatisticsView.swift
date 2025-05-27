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
    @EnvironmentObject var localization: LocalizationManager
    
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
        .background(.themeBG)
        .navigationTitle(LocalizedStringKey("statistics"))
        .onAppear { viewModel.loadData() }
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}

// MARK: - Компоненты

private struct RankCardView: View {
    @ObservedObject var viewModel: StatisticsViewModel
    @EnvironmentObject var localization: LocalizationManager

    var body: some View {
        VStack(spacing: 12) {
            Text(viewModel.currentRank.rawValue)
                .font(.title2.bold())
            
            ProgressView(value: viewModel.rankProgress)
                .frame(height: 8)
            
            if let nextRank = viewModel.currentRank.nextRank {
                HStack{
                    Text(LocalizedStringKey("to"))
                    
                    Text("\(nextRank.rawValue): \(viewModel.pointsToNextRank)")

                    Text(LocalizedStringKey("points"))
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5)
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}

private struct AnswersPieChart: View {
    @ObservedObject var viewModel: StatisticsViewModel
    private let size: CGFloat = 320
    
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
                    Text(LocalizedStringKey("correctly"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: size, height: size)
            
            HStack(spacing: 20) {
                LegendBadge(color: .green, title: "right", count: viewModel.stats.correctAnswers)
                LegendBadge(color: .red, title: "wrong", count: viewModel.stats.questionsAnswered - viewModel.stats.correctAnswers)
            }
            .padding(.top, 10)
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
