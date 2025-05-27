//
//  CategorySelectionView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 20.05.2025.
//
import SwiftUI

struct CategorySelectionView: View {
    @State var observed: HomeView.Observed
    let onSelect: (String) -> Void
    @EnvironmentObject var localization: LocalizationManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 260))], spacing: 16) {
                    ForEach(observed.availableCategories) { category in
                        CategoryCard(
                            title: category.name,
                            icon: category.iconName,
                            action: { onSelect(category.id) }
                        )
                    }
                }
                .padding(20)
            }
            .navigationTitle(LocalizedStringKey("select_category"))
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.locale, .init(identifier: localization.currentLanguage))
        }
    }
}


// Карточка категории
struct CategoryCard: View {
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .frame(width: 48, height: 48)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .multilineTextAlignment(.center)
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(.themeBG)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
        }
        .buttonStyle(ScaleStyle())
    }
}
