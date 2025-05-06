//
//  SettingsView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @State private var showDeleteConfirmation: Bool = false
    @State private var changeTheme: Bool = false
    @State private var showProfileView: Bool = false
    
    @Environment(\.colorScheme) private var scheme
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @AppStorage("selectedLanguage") private var language: String = "ru"
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = false
    
    @State private var currentUser: Profile = .init(id: "", name: "", email: "", score: 0)
    
    let userUID = Auth.auth().currentUser?.uid ?? " "
    var body: some View {
        NavigationStack{
            List{
                Section("Профиль"){
                    VStack(alignment: .leading){
                        //
                        HStack(){
                            Text("Имя: \(currentUser.name.isEmpty ? "Не указано" : currentUser.name)")
                        }
                        //
                        Button{
                            showProfileView.toggle()
                        } label: {
                            Text("Настройки профиля")
                                .background{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.blue)
                                        .padding(.top, 30)
                                }
//                                .foregroundStyle(Color.white)
                        }
                    }
                }
                
                Section("Настройки приложения"){
                    //
                    Picker("Язык", selection: .constant("Русский")) {
                        Text("Русский").tag("Русский")
                        Text("Английский").tag("Английский")
                    }
                    //
                    Button("Сменить тему"){
                        changeTheme.toggle()
                    }.foregroundColor(.primary)
                    
                }
                
                Section("Уведомления"){
                    Toggle(isOn: .constant(true)) {
                        Text("Получать уведомления")
                    }
                }
            }
            .navigationTitle("Настройки")
        }
        .preferredColorScheme(userTheme.colorScheme)
        .sheet(isPresented: $changeTheme, content: {
                ThemeChangeView(scheme: scheme)
                    .presentationDetents([.height(410)])
                    .presentationBackground(.clear)
        })
        .sheet(isPresented: $showProfileView, content: {
            ProfileView()
        })

    }
}

#Preview {
    SettingsView()
}
