//
//  AuthView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import SwiftUI

struct AuthView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirm: String = ""
    
    var body: some View {
        VStack(spacing: 12){
            Image(systemName: "apple.intelligence")
                .resizable()
                .scaledToFit()
                .frame(width: 140)
            Text("Git Quiz")
                .font(.title).bold()
                .foregroundStyle(.gitYellow)
                .padding(.top, 27)
                .padding(.bottom, 14)
            TextField("Ввудите ваш email", text: $email)
        }
        .padding(.horizontal, 43)
    }
}

#Preview {
    ContentView()
}
