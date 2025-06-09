//
//  AchievementDetailView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 31.05.2025.
//
import SwiftUI

// MARK: - Детальный просмотр достижения
struct AchievementDetailView: View {
    let achievement: Achievement
    @State private var rotation: Double = 0
    @State private var notchLength: CGSize = .zero
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 30) {
            // Заголовок
            Text(achievement.title)
                .font(.title.bold())
                .padding(.top, 20)
            
            // Анимированная медаль
            ZStack {
                Image(achievement.imageName)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gitOrange, lineWidth: 4))
                    .padding(30)
                    .rotationEffect(.degrees(rotation))
                    .shadow(color: .gitOrange.opacity(0.4), radius: 20, x: 0, y: 0)
                
                ArcShape(
                    length: notchLength.width,
                    lineWidth: notchLength.height,
                    gap: 8
                )
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [.gitOrange, .yellow, .gitOrange]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round, dash: [2, 4])
                )
                .rotationEffect(.degrees(-90))
                .rotationEffect(.degrees(rotation * 1.2))
                .padding(10)
            }
            .frame(width: 250, height: 250)
            .overlay(alignment: .top) {
                CurvedText(
                    text: achievement.title, 
                    radius: 125,
                    fontSize: 20
                )
                .foregroundColor(.gitOrange)
                .fontWeight(.bold)
                .onSizeChange { size in
                    notchLength = size
                }
            }
            .onAppear {
                withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
            
            // Описание
            Text(achievement.description)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            // Кнопка закрытия
            Button(action: { dismiss() }) {
                Text("Закрыть")
                    .font(.headline)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.gitOrange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            AnimatedMeshGradient()
                .blur(radius: 30)
                .ignoresSafeArea()
        )
    }
}
