//
//  DetailedStatsView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 07.05.2025.
//
import SwiftUI


struct DetailedStatsView: View {
    @ObservedObject var viewModel: StatisticsViewModel
    @EnvironmentObject var localization: LocalizationManager

    var body: some View {
        VStack(spacing: 12) {
            SectionHeader(title: "detailed_statistics")
            
            VStack(spacing: 8) {
                StatRow(title: "total_time_in_game", 
                       value: viewModel.formattedTotalPlayTime)
                Divider()
                StatRow(title: "the_fastest_passage", 
                       value: viewModel.formattedFastestQuiz)
                Divider()
                StatRow(title: "the_longest_passage", 
                       value: viewModel.formattedSlowestQuiz)
                Divider()
                StatRow(title: "total_questions_answered", 
                       value: "\(viewModel.stats.questionsAnswered)")
                Divider()
                StatRow(title: "percentage_of_correct_answers",
                       value: viewModel.correctPercentage)
                Divider()
                StatRow(title: "hints_used", 
                       value: "\(viewModel.stats.hintsUsed)")
            }
            .padding()
            .background(.colorBG)
            .cornerRadius(12)
            .shadow(radius: 2)
        }
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}

// MARK: - Вспомогательные компоненты
private struct SectionHeader: View {
    let title: String
    @EnvironmentObject var localization: LocalizationManager

    var body: some View {
        HStack {
            Text(LocalizedStringKey(title))
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
        }
        .environment(\.locale, .init(identifier: localization.currentLanguage))
        .padding(.leading)
    }
}

private struct StatRow: View {
    let title: String
    let value: String
    @EnvironmentObject var localization: LocalizationManager
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(title))
                .font(.subheadline)
            
            Spacer()
            
            Text(value)
                .font(.subheadline.bold())
                .foregroundColor(.primary)
        }
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}

// MARK: - Расширение для форматирования
extension StatisticsViewModel {
    var formattedTotalPlayTime: String {
        formatTime(seconds: stats.totalPlayTime)
    }
    
    var formattedFastestQuiz: String {
        stats.fastestQuiz > 0 ? formatTime(seconds: stats.fastestQuiz) : "N/A"
    }
    
    var formattedSlowestQuiz: String {
        formatTime(seconds: stats.slowestQuiz)
    }
    
    var correctPercentage: String {
        guard stats.questionsAnswered > 0 else { return "0%" }
        let percentage = Double(stats.correctAnswers) / Double(stats.questionsAnswered) * 100
        return String(format: "%.1f%%", percentage)
    }
    
    private func formatTime(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: TimeInterval(seconds)) ?? "0 сек"
    }
}
