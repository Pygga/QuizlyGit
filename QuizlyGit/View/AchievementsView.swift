//
//  AchievementsView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 31.05.2025.
//
import SwiftUI

struct AchievementsView: View {
    @StateObject private var viewModel = AchievementsViewModel()
    @State private var showDetail: Achievement?
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 20) {
                ForEach(viewModel.achievements) { achievement in
                    AchievementCircularView(achievement: achievement, title: achievement.title)
//                        .font(.system(size: 13, design: .monospaced))
                        .frame(width: 120, height: 120)
                        .onTapGesture {
                            if achievement.isUnlocked {
                                showDetail = achievement
                            }
                        }
                        .scaleEffect(achievement.isUnlocked ? 1 : 0.9)
                        .opacity(achievement.isUnlocked ? 1 : 0.8)
                        .animation(.spring, value: achievement.isUnlocked)
                        .padding(15)
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Достижения")
        .onAppear { viewModel.loadAchievements() }
        .sheet(item: $showDetail) { achievement in
            AchievementDetailView(achievement: achievement)
        }
    }
}
