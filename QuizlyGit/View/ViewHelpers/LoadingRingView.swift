//
//  LoadingRingView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 25.05.2025.
//
import SwiftUI
import Combine

struct LoadingRingView: View {
    let text: String
    @Binding var progress: Double? // Опциональный прогресс (nil для бесконечной анимации)
    @State private var rotationAngle: Double = 0
    @State private var dotsCount = 0
    @State private var timer: AnyCancellable?
    
    var loadingText: String {
        text + String(repeating: ".", count: dotsCount)
    }
    
    // Настройки
    private let lineWidth: CGFloat = 20
    private let size: CGFloat = 250
    private let gradient = LinearGradient(
        gradient: Gradient(colors: [.mintBG, .cyanBG, .blueBG]),
        startPoint: .leading,
        endPoint: .trailing
    )
    // Настройки фонового кольца
    private let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [.cyanBG, .moon, .blueBG]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        ZStack {
            // Фоновое кольцо
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(.gray.opacity(0.2))
            
            // Дополнительное кольцо с быстрой анимацией
            Circle()
                .trim(from: 0, to: CGFloat(progress ?? 0.8))
                .stroke(
                    backgroundGradient,
                    style: StrokeStyle(
                        lineWidth: lineWidth - 2,
                        lineCap: .round,
                    )
                )
                .rotationEffect(.degrees(-90))
                .rotationEffect(.degrees(rotationAngle * 1.2)) // На 20% быстрее
                .blur(radius: 2)
                .opacity(0.7)
            
            // Анимированное кольцо
            Circle()
                .trim(from: 0, to: CGFloat(progress ?? 0.75))
                .stroke(
                    gradient,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90)) // Начало анимации сверху
                .rotationEffect(.degrees(rotationAngle))
                .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 0)
            // Текст
            VStack(spacing: 8) {
                if let progress = progress {
                    Text("\(Int(progress * 100))%")
                        .font(.system(size: 42, weight: .bold))
                        .contentTransition(.numericText())
                }
                
                Text(text)
                    .font(.title3)
                    .multilineTextAlignment(.center)
//                    .contentTransition(.interpolate)
//                    .animation(.easeInOut(duration: 0.15), value: dotsCount)
            }
            .padding(20)
            .zIndex(1) // Поднимаем текст поверх колец
        }
        .frame(width: size, height: size)
        .onAppear {
            rotationAngle = 360
//            startDotsAnimation()
        }
        .onDisappear {
//            stopDotsAnimation()
        }
        .onChange(of: progress) { _ in
            if progress != nil {
                rotationAngle += 360
            }
        }
        .animation(
            progress == nil ?
                .linear(duration: 1.5).repeatForever(autoreverses: true) :
                .easeInOut(duration: 1),
            value: rotationAngle
        )
    }
    
    private func startDotsAnimation() {
        timer = Timer.publish(every: 0.15, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                withAnimation(.easeInOut(duration: 0.3)) {
                    dotsCount = (dotsCount + 1) % 4 // Цикл 0...3
                }
            }
    }
    
    private func stopDotsAnimation() {
        timer?.cancel()
        timer = nil
    }
}
