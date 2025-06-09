//
//  AchievementCircularView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 31.05.2025.
//
import SwiftUI

struct AchievementCircularView: View {
    @State private var notchLenght: CGSize = .zero
    let achievement: Achievement
    var title: String
    
    var body: some View {
//        VStack{
            GeometryReader { geometry in
                let size = geometry.size
                VStack{
                    ZStack {
                        Image(achievement.isUnlocked ? achievement.imageName : "achievement")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                            .padding(20)
                            .grayscale(achievement.isUnlocked ? 0 : 1)
                            .opacity(achievement.isUnlocked ? 1 : 0.6)
                        
                        ArcShape(
                            //startAngle: .degrees(0),
                            length: notchLenght.width,
                            lineWidth: notchLenght.height,
                            gap: 8
                        )
                        .stroke(achievement.isUnlocked ? Color.gitOrange : Color.gray, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .rotationEffect(.degrees(-90))
//                        .padding(8)
                    }
                    .frame(width: size.width, height: size.height)
//                    .frame(width: 120, height: 120)
                    .overlay(alignment: .top) {
                        CurvedText(text: title, radius: (size.width / 2))
                            .foregroundColor(achievement.isUnlocked ? .gitOrange : .gray)
                            .onGeometryChange(for: CGSize.self) { proxy in
                                proxy.size
                            } action: { size in
                                notchLenght = size
                            }
                        
                    }
                    // Описание (только для разблокированных)
                    if achievement.isUnlocked {
                        Text(achievement.description)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(width: 120)
                    }
                }
                .padding(10)
                .background(achievement.isUnlocked ? Color.themeBG.opacity(0.2) : Color.gray.opacity(0.1))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(achievement.isUnlocked ? Color.gitOrange : Color.gray, lineWidth: 1)
                )
                
            }
    }
}
