//
//  StatsGrid.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 23.05.2025.
//
import SwiftUI

struct StatsGrid: View {
    @ObservedObject var viewModel: StatisticsViewModel
    @EnvironmentObject var localization: LocalizationManager

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            StatCard(title: "game_played", value: "\(viewModel.stats.gamesPlayed)")
            StatCard(title: "stat_total_score", value: "\(viewModel.stats.totalScore)")
            StatCard(title: "stat_correct_answers", value: "\(viewModel.stats.correctAnswers)")
            StatCard(title: "average_time", value: "\(viewModel.averageTimePerGame)s")
        }
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}
