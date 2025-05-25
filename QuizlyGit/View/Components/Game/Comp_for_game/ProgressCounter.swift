//
//  ProgressCounter.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 25.05.2025.
//
import SwiftUI

struct ProgressCounter: View {
    
    let current: Int
    let total: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .frame(width: 150, height: 12)
                .foregroundColor(Color(.systemGray5))
            
            Capsule()
                .frame(
                    width: CGFloat(current) / CGFloat(total) * 150,
                    height: 12
                )
                .foregroundColor(.blue)
                .animation(.easeInOut, value: current)
            
            Text("\(current)/\(total)")
                .font(.system(size: 10, weight: .medium, design: .monospaced))
                .foregroundColor(.white)
                .padding(4)
                .background(Capsule().fill(Color.blue))
                .offset(x: CGFloat(current) / CGFloat(total) * 150 - 24)
        }
    }
}
