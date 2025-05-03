//
//  ContentView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import SwiftUI

struct ContentView: View {
    @State var observed: Observed = .init()
    
    var body: some View {
        
        if observed.appState == .authorized{
            HomeView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.themeBG)
        } else {
            AuthView(routeObserved: observed)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background{
//                    AnimatedMeshGradient()
//                        .ignoresSafeArea()
//                        .blur(radius: 50, opaque: true)
//                }
//                .background(LinearGradient(colors: [.gitYellow, .gitOrange], startPoint: .topLeading, endPoint: .bottomTrailing))
        }
    }
}

extension ContentView{
    @Observable class Observed{
        var appState: AppState = .unauthorized
    }
}


enum AppState{
    case unauthorized
    case authorized
}

#Preview {
    ContentView()
}
