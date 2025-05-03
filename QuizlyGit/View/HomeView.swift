//
//  HomeView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import SwiftUI


struct HomeView: View {
//    @State private var profile: Profile
    @State private var observed = Observed()
    @State private var navigateToGame = false
    @State private var showMenu: Bool = false
    
//    @State private var scrollPosition: ScrollPosition = .init()
    @State private var currentScrollOffset: CGFloat = 0
    @State private var timer = Timer.publish(every: 0.01, on: .current, in: .default).autoconnect()
    
    @State private var selectedTab: Tab = .home
    private func makeGameView() -> some View {
        GameView(viewModel: GameViewModel(config: makeConfig()))
    }
    
    var body: some View {
        AnimatedSideBar(
            rotatesWhenExpands: true,
            disablesInteraction: true,
            sideMenuWidth: 200,
            cornerRadius: 20,
            showMenu: $showMenu,
            selectedTab: $selectedTab
        ){ safeArea in
            NavigationStack{
                ZStack{
                    // Header
                    
                    VStack(spacing: 20) {
                        
                        VStack {
                            Text("Добро пожаловать, \(observed.currentProfile.name.isEmpty ? observed.currentProfile.email : observed.currentProfile.name)!")
                                .font(.title)
                            Text("Хорошей игры!")
                                .font(.subheadline)
                        }
                        .padding(.top, 40)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(observed.availableCategories) { category in
                                    CategoryButtonView(
                                        category: category,
                                        isSelected: observed.selectedCategories.contains(category.id)
                                    ) {
                                        observed.toggleCategory(category.id)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .containerRelativeFrame(.horizontal) { length, axis in
                            length * 0.9
                        }
                        NavigationLink(destination: makeGameView(), label: { Text("Играть")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                            .cornerRadius(10) })
                        // Кнопка Играть
                        
                    }
                    .padding()
                }
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: { showMenu.toggle() }, label: {
                            Image(systemName: showMenu ? "xmark" : "line.3.horizontal")
                                .foregroundStyle(Color.primary)
                                .contentTransition(.symbolEffect)                            
                        })
                    }
                }
            }
        } menuView: { saveArea in
            SideBarMenuView(safeArea: safeArea, selectedTab: $selectedTab)
        } background: {
            Rectangle()
                .fill(.darkGrey)
        }
    }
    
    private func makeConfig() -> QuizConfig {
        let isPreset = observed.selectedCategories.isEmpty
        return QuizConfig(
            categories: Array(observed.selectedCategories),
            isPresetTest: isPreset,
            showHints: true,  // Берем значение из настроек или используем true по умолчанию
            timePerQuestion: 30,
            questionsCount: 15
        )
    }
}

#Preview {
    HomeView()
}
