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
                HStack {
                    Text("Подсказка")
                        .font(.title3.bold())
                    
                    Spacer()
                    
                }
                
                Text(hint.text)
                    .font(.body)
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
            }
        .padding([.horizontal, .vertical], 15)
        .background{
            RoundedRectangle(cornerRadius: 20)
                .fill(.background)
                .padding(.top, 30)
        }

        .frame(maxWidth: 310, maxHeight: 400)
        .shadow(radius: 10)
        .compositingGroup()
        .transition(.move(edge: .bottom))
        .animation(.easeInOut, value: isPresented)
    }
}
