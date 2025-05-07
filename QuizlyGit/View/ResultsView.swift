//
//  ResultsView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 01.05.2025.
//

import SwiftUI

struct ResultsView: View {
    let results: GameResults
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Результаты теста")
                .font(.largeTitle)
                .padding(.bottom, 20)
            
            VStack(spacing: 15) {
                ResultRow(
                    title: "Правильные ответы",
                    value: "\(results.correctAnswers)/\(results.totalQuestions)",
                    systemImage: "checkmark.circle.fill",
                    color: .green
                )
                
                ResultRow(
                    title: "Затраченное время",
                    value: formattedTime(results.totalTime),
                    systemImage: "clock.fill",
                    color: .blue
                )
                
                ResultRow(
                    title: "Использовано подсказок",
                    value: "\(results.usedHints)",
                    systemImage: "lightbulb.fill",
                    color: .orange
                )
                
                ResultRow(
                    title: "Итоговый счет",
                    value: "\(results.finalScore)",
                    systemImage: "star.fill",
                    color: .purple
                )
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(15)
            .shadow(radius: 5)
            
            Spacer()
            
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Text("Вернуться на главную")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                AnimatedMeshGradient()
                    .mask(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(lineWidth: 16)
                            .blur(radius: 8)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white ,lineWidth: 3)
                            .blur(radius: 2)
                            .blendMode(.overlay)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.white ,lineWidth: 1)
                            .blur(radius: 1)
                            .blendMode(.overlay)
                    )
            )
            .background(.black)
            .cornerRadius(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.black.opacity(0.5) ,lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.15), radius: 20, x: 0 ,y: 20)
            .shadow(color: .black.opacity(0.1), radius: 15, x: 0 ,y: 15)
            .foregroundStyle(.white)
        }
        .padding()
        .navigationBarHidden(true)
    }
    
    private func formattedTime(_ seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: TimeInterval(seconds)) ?? "0:00"
    }
}
