//
//  TestSettingsView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 08.05.2025.
//
import SwiftUI

struct TestSettingsView: View {
    @Bindable var observed: HomeView.Observed
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var localization: LocalizationManager
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("test_settings")) {
                    Stepper(value: $observed.questionsCount, in: 5...50) {
                        HStack{
                            Text(LocalizedStringKey("number_of_questions"))
                            Text("\(observed.questionsCount)")
                        }
                    }
                    
                    Stepper(value: $observed.timePerQuestion, in: 10...60) {
                        HStack{
                            Text(LocalizedStringKey("time_to_ask"))
                            Text("\(observed.timePerQuestion)")
                        }
                    }
                    Toggle(LocalizedStringKey("show_hints"), isOn: $observed.showHints)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(height: 410)
            .background(.themeBG)
            .clipShape(.rect(cornerRadius: 30))
            .padding(.horizontal, 15)

        }
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
}
