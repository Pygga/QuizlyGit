//
//  CategorySelectionView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 20.05.2025.
//
import SwiftUI

struct CategorySelectionView: View {
    @State var observed: HomeView.Observed
    @State private var showTestSettings = false
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
                .toolbar{
                    ToolbarItem(placement: .bottomBar) {
                        HStack{
                            Spacer()
                            Button(action: {
    //                            gameConfig = observed.currentConfig
                                showTestSettings.toggle()}) {
                                    Image(systemName: "gearshape.2.fill")
                                        .foregroundStyle(Color.primary)
                                        .contentTransition(.symbolEffect)
                                }
                                .padding(.trailing, 12)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .sheet(isPresented: $showTestSettings) {
                TestSettingsView(observed: observed)
                    .presentationDetents([.height(310)])
                    .presentationBackground(.clear)
            }
            .navigationTitle(LocalizedStringKey("select_category"))
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.locale, .init(identifier: localization.currentLanguage))
        }
    }
}
