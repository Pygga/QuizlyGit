//
//  HintView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 01.05.2025.
//
import SwiftUI

// Модель для модального окна подсказки
struct HintView: View {
    let hint: Hint
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture { dismiss() }
                .opacity(isPresented ? 1 : 0)
                .animation(.easeInOut, value: isPresented)
            
            if isPresented {
                VStack(spacing: 20) {
                    
                    Image(systemName: "lightbulb")
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(width: 65, height: 65)
                        .background(.gitOrange.gradient, in: .circle)
                        .background{
                            Circle()
                                .stroke(.background, lineWidth: 8)
                        }
//                    HStack {
//                        Text("Подсказка")
//                            .font(.title3.bold())
//                        
//                        Spacer()
//                        
//                    }
                    
                    Text(hint.text)
                        .font(.title3.bold())
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.vertical, 4)

                    HStack{
                        if let url = URL(string: hint.link) {
                            Link("Документация", destination: url)
                                .buttonStyle(.borderedProminent)
                                .tint(.gitYellow)
                        }
                        
                        Button(action: { isPresented = false }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .foregroundColor(.red)
                        }
                        .frame(width: 25, height: 25, alignment: .topTrailing)
                        .padding(.leading, 15)
                    }
                    .padding(.bottom, 15)
                    .padding(.horizontal, 50)
                }

                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.background)
                        .shadow(radius: 10)
                )
                .padding()
                .transition(.scale.combined(with: .opacity))
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPresented)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
    
    private func dismiss() {
        withAnimation {
            isPresented = false
        }
    }
}
