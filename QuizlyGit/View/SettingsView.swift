//
//  SettingsView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .center) {
                Text("World!")
                    .frame(width: .infinity, height: 200)
                    .background(Color.red)

            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SettingsView()
}
