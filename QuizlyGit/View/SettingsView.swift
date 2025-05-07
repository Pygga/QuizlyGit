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
    
//    @State private var currentUser: Profile = .init(id: "", name: "", email: "", score: 0)
    @StateObject private var viewModel = SettingsViewModel()
    
    let userUID = Auth.auth().currentUser?.uid ?? " "
    var body: some View {
        NavigationStack{
            List{
                Section("Профиль"){
                    VStack(alignment: .leading){
                        //
                        HStack{
                            Text("Имя: \(viewModel.currentUser.name.isEmpty ? "Не указано" : viewModel.currentUser.name)")
                            Spacer()
                            Text("Очки: \(viewModel.currentUser.score)")
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
                    Picker("Язык", selection: $viewModel.settings.language) {
                        Text("Русский").tag("ru")
                        Text("English").tag("en")
                    }
                    //
                    Button("Сменить тему"){
                        changeTheme.toggle()
                    }.foregroundColor(.primary)
                    
                }
                
                Section("Уведомления"){
                    Toggle("Получать уведомления", isOn: $viewModel.settings.notificationsEnabled)
                        .onChange(of: viewModel.settings.notificationsEnabled) { enabled in
                        if enabled {
                            requestNotificationPermission()
                        } else {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        }
                    }
                }
            }
            .navigationTitle("Настройки")
            .task { await viewModel.saveSettings()
                await viewModel.loadData() }
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
    
    // MARK: - Notification Setup
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            if granted {
                scheduleDailyNotifications()
            }
        }
    }
    
    private func scheduleDailyNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Не забудьте зайти в приложение!"
        content.body = "Проверьте свои достижения и новые вопросы"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 86400, // 24 часа
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: "dailyReminder",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
}

#Preview {
    SettingsView()
}
