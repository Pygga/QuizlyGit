//
//  AuthView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import SwiftUI

struct AuthView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirm: String = ""
    @State private var isAuth: Bool = true
    @State private var observed: Observed = Observed()
    
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
            CustomTextField(isSecure: false, title: "Ваш Email", text: $email)
            CustomTextField(isSecure: true, title: "Ваш пароль", text: $password)
            
            if !isAuth{
                CustomTextField(isSecure: true, title: "Повторите пароль ", text: $confirm)
            }
            CustomButton(title: isAuth ? "Войти" : "Регистрация"){
                if isAuth {
                    observed.auth(email: email, password: password)
                    
                } else {
                    observed.singUp(email: email, password: password, confirmPassword: confirm)
                    
                }
//                logStatus = true
//                routeObserved.appState = .authorized
            }
            .padding(.bottom, 9)
            Button(isAuth ? "Еще не с нами?" : "Уже есть аккаунт?") {
                withAnimation{
                    isAuth.toggle()
                }
            }
            .font(.callout)
            .tint(.gray)

        } .onChange(of: observed.currentProfile) { _, newValue in
            logStatus = (newValue != nil) // Обновляем logStatus при изменении currentProfile
        }
        .alert("Ошибка", isPresented: Binding<Bool>(
            get: { observed.errorMessage != nil },
            set: { _ in observed.errorMessage = nil }
        )) {
            Button("OK") { }
        } message: {
            Text(observed.errorMessage ?? "")
        }
        .padding(.horizontal, 43)
    }
}

#Preview {
    ContentView()
}
