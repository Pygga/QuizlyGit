//
//  ContentView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @AppStorage("log_status") var logStatus: Bool = false
    @State var observed: Observed = .init()
    var body: some View {
        
        if logStatus{
            HomeView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.themeBG)
                .preferredColorScheme(userTheme.colorScheme)
        } else {
            AuthView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme(userTheme.colorScheme)
                .background(.themeBG)
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
