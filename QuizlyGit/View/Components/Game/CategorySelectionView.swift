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
            .navigationTitle("Выберите категорию")
            .navigationBarTitleDisplayMode(.inline)
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
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
        }
        .buttonStyle(ScaleStyle())
    }
}

// Стиль кнопки с анимацией нажатия
struct ScaleStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
