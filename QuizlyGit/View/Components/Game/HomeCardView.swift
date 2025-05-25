//
//  HomeCardView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 20.05.2025.
//

import SwiftUI

struct HomeCardView: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    let action: () -> Void
    @EnvironmentObject var localization: LocalizationManager
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text(LocalizedStringKey(title))
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(LocalizedStringKey(description))
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(color)
            .cornerRadius(15)
            .shadow(radius: 5)
        }
    }
}
