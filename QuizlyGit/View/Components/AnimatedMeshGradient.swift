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
                    appear2 ? .redCust : .gitOrange,appear2 ? .darkGrey : .gitOrange, .darkGrey,
                    appear ? .redCust : .gitYellow, appear ? .gitOrange: .sun, .gitYellow,
                    appear ? .darkGrey : .redCust, appear ? .redCust : .gitYellow, appear2 ? .gitOrange : .sun
                ]
//                colors: [
//                    appear2 ? .redCust : .mint, appear2 ? .yellow : .cyan, .gitOrange,
//                    appear ? .blue : .red, appear ? .cyan : .white, appear ? .red : .purple,
//                    appear ? .red : .cyan, appear ? .mint : .blue, appear ? .red : .blue
//                ]
            )
            .onAppear{
                withAnimation(.easeInOut(duration : 1).repeatForever(autoreverses: true)){
                    appear.toggle()
                }
                
                withAnimation(.easeInOut(duration : 2).repeatForever(autoreverses: true)){
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
