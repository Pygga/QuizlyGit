//
//  AnimatedMeshGradient.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 02.05.2025.
//

import SwiftUI

struct AnimatedMeshGradient: View {
    @State var appear = false
    @State var appear2 = false
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    var body: some View {
        if #available(iOS 18.0, *) {
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [0.0, 0.0], [appear2 ? 0.5 : 1.0, 0.0], [1.0, 0.0],
                    [0.0, 0.5],appear ? [0.1, 0.5] : [0.8, 0.3], [1.0, -0.5],
                    [0.0, 1.0], [1.0, 1.0], [ appear2 ? 2.0 : 1.0,1.0]
                ],
               colors: [
                    appear2 ? .whiteBG : .mintBG, appear2 ? .whiteBG : .cyanBG, .whiteBG,
                    appear ? .blueBG : .whiteBG, appear ? .cyanBG : .whiteBG, appear ? .whiteBG : .purpleBG,
                    appear ? .whiteBG : .cyanBG, appear ? .mintBG : .whiteBG, appear ? .whiteBG : .blueBG
                ]
                
            )
            .onAppear{
                withAnimation(.easeInOut(duration : 2).repeatForever(autoreverses: true)){
                    appear.toggle()
                }
                
                withAnimation(.easeInOut(duration : 3).repeatForever(autoreverses: true)){
                    appear2.toggle()
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    AnimatedMeshGradient()
        .ignoresSafeArea()
}
