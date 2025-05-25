//
//  ProgressBarView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 20.05.2025.
//
import SwiftUI

struct ProgressBarView: View {
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(
                        width: min(progress * geometry.size.width, geometry.size.width),
                        height: geometry.size.height
                    )
                    .foregroundColor(.gitOrange)
                    .animation(.linear, value: progress)
            }
            .cornerRadius(4)
        }
    }
}
