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
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = false
    
    @Bindable var observed: HomeView.Observed
    @StateObject private var viewModel: SettingsViewModel
    @EnvironmentObject var localization: LocalizationManager
    
    init(observed: HomeView.Observed) {
        self.observed = observed
        self._viewModel = StateObject(wrappedValue: SettingsViewModel(observed: observed))
    }
    
    let userUID = Auth.auth().currentUser?.uid ?? " "
    var body: some View {
        NavigationStack{
            List{
                Section(LocalizedStringKey("profile")){
                    VStack(alignment: .leading){
                        HStack{
                            Text(LocalizedStringKey("name"))
                            Text(": \(viewModel.currentUser.name.isEmpty ? Text(String(format:LocalizationManager.shared.localizedString("not_specified")) ) : Text(viewModel.currentUser.name))")
                        }
                        //Кнопка перехода на экран редактирования профиля
                        Button{
                            showProfileView.toggle()
                        } label: {
                            Text(LocalizedStringKey("profile_settings"))
                                .background{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.blue)
                                        .padding(.top, 30)
                                }
                        }
                    }
                }
                
                Section(LocalizedStringKey("app_settings")){
                    //Выбор языка
                    Picker(LocalizedStringKey("language"), selection: $localization.currentLanguage) {
                        Text("Русский").tag("ru")
                        Text("English").tag("en")
                    }
                    .onChange(of: viewModel.settings.language) { newValue in
                        localization.currentLanguage = newValue
                        print(viewModel.settings.language)
                        print("\\\\\\\\\\\\")
                    }
                    //Выбор темы
                    Button(LocalizedStringKey("change_theme")){
                        changeTheme.toggle()
                    }.foregroundColor(.primary)
                    
                }
                
                Section(LocalizedStringKey("notifications")){
                    //Уведомления
                    Toggle(LocalizedStringKey("receive_notifications"), isOn: $viewModel.settings.notificationsEnabled)
                        .onChange(of: viewModel.settings.notificationsEnabled) { enabled in
                        if enabled {
                            requestNotificationPermission()
                        } else {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        }
                    }
                }
            }
            .navigationTitle(LocalizedStringKey("title_settings"))
            .task {await viewModel.loadData()
                viewModel.saveSettings()
                 }
        }
        .preferredColorScheme(userTheme.colorScheme)
        .sheet(isPresented: $changeTheme, content: {
                ThemeChangeView(scheme: scheme)
                    .presentationDetents([.height(410)])
                    .presentationBackground(.clear)
        })
        .sheet(isPresented: $showProfileView, content: {
            ProfileView(viewModel: viewModel)
        })
        .environment(\.locale, .init(identifier: localization.currentLanguage))
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
