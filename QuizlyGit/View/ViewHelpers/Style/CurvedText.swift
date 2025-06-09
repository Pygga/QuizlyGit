//
//  CurvedText.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 31.05.2025.
//
import SwiftUI

struct CurvedText: View {
    let text: String
    let radius: CGFloat
    var fontSize: CGFloat = 14
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(text.enumerated()), id: \.offset) { _, char in
                Text(String(char))
                    .font(.system(size: fontSize, weight: .medium))
            }
        }
        .fixedSize()
        .hidden()
        .overlay {
            GeometryReader { fullText in
                let textWidth = fullText.size.width
                let arcAngle = radius > 0 ? (textWidth / radius) : 0
                let startAngle = -(arcAngle / 2)
                
                HStack(spacing: 0) {
                    ForEach(Array(text.enumerated()), id: \.offset) { index, char in
                        Text(String(char))
                            .font(.system(size: fontSize, weight: .medium))
                            .hidden()
                            .overlay {
                                GeometryReader { charSpace in
                                    let midX = charSpace.frame(in: .named("FullText")).midX
                                    let fraction = midX / textWidth
                                    let angle = startAngle + (fraction * arcAngle)
                                    let xOffset = (textWidth / 2) - midX
                                    
                                    Text(String(char))
                                        .font(.system(size: fontSize, weight: .medium))
                                        .offset(y: -radius)
                                        .rotationEffect(.radians(angle))
                                        .offset(x: xOffset, y: radius)
                                }
                            }
                    }
                }
                .fixedSize()
                .coordinateSpace(name: "FullText")
            }
        }
    }
}
