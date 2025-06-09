//
//  HomeView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var observed = Observed()
    @State private var navigateToGame = false
    @State private var showMenu: Bool = false
//    @State private var showTestSettings = false
    @State private var selectedCategory: String?
    @State private var showingCategorySelection = false
    @State private var activeGameView: Bool = false
    @State private var currentScrollOffset: CGFloat = 0
    
    @State private var navigationPath = NavigationPath()
    @State private var selectedTab: Tab = .home
    @State private var gameConfig: QuizConfig?
    @State private var trigger: Bool = false
    @EnvironmentObject var localization: LocalizationManager
    
    private func makeGameView() -> some View {
        GameView(viewModel: GameViewModel(config: makeConfig()), onExit: { navigationPath.removeLast(navigationPath.count)})
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
            NavigationStack(){
                Group {
                    ZStack{
                        AnimatedMeshGradient()
                            .blur(radius: 100, opaque: true)
                            .ignoresSafeArea()
                        switch selectedTab {
                        case .home:
                            NavigationStack(path: $navigationPath){
                                mainContentView
                                    .navigationDestination(for: String.self) { destination in
                                        switch destination {
                                        case "category":
                                            CategorySelectionView(observed: observed) { category in
                                                gameConfig = QuizConfig(
                                                    categories: [category],
                                                    showHints: observed.showHints,
                                                    timePerQuestion: observed.timePerQuestion,
                                                    questionsCount: observed.questionsCount,
                                                    stopOnWrongAnswer: false
                                                )
                                                navigationPath.count > 1 ? navigationPath.removeLast() : ()
                                                navigationPath.append("game")
                                            }
                                        case "game":
                                            GameView(viewModel: GameViewModel(config: gameConfig ?? observed.currentConfig),onExit: { navigationPath.removeLast()})
                                                .navigationBarHidden(true)
                                        default:
                                            EmptyView()
                                        }
                                    }
                            }
                        case .statistics:
                            StatisticsView()
                                .background(.themeBG)
                        case .rating:
                            RatingView()
                        case .settings:
                            SettingsView(observed: observed)
                                .background(.settingsBG)
                        case .achievement:
                            AchievementsView()
                                .background(.themeBG)
                        case .logout:
                            EmptyView()
                        }
                    }
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
            SideBarMenuView(safeArea: safeArea, selectedTab: $selectedTab, closeMenu: { showMenu = false })
        } background: {
            Rectangle()
                .fill(.darkGrey)
        }
    }
    
    private var mainContentView: some View {
        ZStack{
            AnimatedMeshGradient()
                .blur(radius: 100, opaque: true)
                .ignoresSafeArea()
            // Header
            ScrollView {
                VStack(spacing: 20) {
                    HeaderView()
                    
                    Spacer()
                    
                    NavigationCard(
                            icon: "list.bullet",
                            title: "select_category",
                            subtitle: "category_description",
                            color: LinearGradient(
                                colors: [
                                    Color(.sRGB, red: 0.3686, green: 0.5059, blue: 0.9569),
                                    Color(.sRGB, red: 0.2510, green: 0.4039, blue: 0.8392)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            action: {
                                navigationPath.append("category") }
                        )
                    NavigationCard(
                            icon: "questionmark.circle.fill",
                            title: "full_test",
                            subtitle: "full_test_description",
                            color: LinearGradient(
                                colors: [
                                    Color(.sRGB, red: 0.4275, green: 0.8392, blue: 0.6275),
                                    Color(.sRGB, red: 0.2941, green: 0.7490, blue: 0.5255)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            action: {
                                gameConfig = QuizConfig(
                                    categories: ["Git Basics","Advanced", "Branching", "Remote", "Undo"],
                                    showHints: observed.showHints,
                                    timePerQuestion: observed.timePerQuestion,
                                    questionsCount: QuestionStorage.shared.allQuestions.count,
                                    stopOnWrongAnswer: false
                                )
//                                if gameConfig != nil {
                                    navigationPath.append("game")
//                                }
                                
                            }
                    )
                    NavigationCard(
                        icon: "xmark.circle.fill",
                        title: "survival_mode",
                        subtitle: "survival_description",
                        color: LinearGradient(
                            colors: [
                                Color(.sRGB, red: 1.0000, green: 0.4824, blue: 0.4824),
                                Color(.sRGB, red: 0.9020, green: 0.3529, blue: 0.3529)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        action: {
                            
                            gameConfig = QuizConfig(
                                categories: ["Git Basics","Advanced", "Branching", "Remote", "Undo"],
                                showHints: observed.showHints,
                                timePerQuestion: observed.timePerQuestion,
                                questionsCount: QuestionStorage.shared.allQuestions.count,
                                stopOnWrongAnswer: true
                            )
                        

//                        if gameConfig != nil {
                            navigationPath.append("game")
//                        }
                    }
                    )
                }
                .padding(.horizontal)
//                .sheet(isPresented: $showTestSettings) {
//                    TestSettingsView(observed: observed)
//                        .presentationDetents([.height(310)])
//                        .presentationBackground(.clear)
//                }
            }
//            .toolbar{
//                ToolbarItem(placement: .bottomBar) {
//                    HStack{
//                        Spacer()
//                        Button(action: {
////                            gameConfig = observed.currentConfig
//                            showTestSettings.toggle()}) {
//                                Image(systemName: "gearshape.2.fill")
//                                    .foregroundStyle(Color.primary)
//                                    .contentTransition(.symbolEffect)
//                            }
//                            .padding(.trailing, 12)
//                    }
//                }
//            }
        }
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
    
    private func makeConfig() -> QuizConfig {
            observed.currentConfig // Используем вычисляемое свойство
        }
}

// Персонализированное приветствие
private struct HeaderView: View {
    @State private var observed = HomeView.Observed()
    @State private var trigger: Bool = false
    @EnvironmentObject var localization: LocalizationManager
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                HackerTextView(text: getTimeDependentGreeting(), trigger: trigger, transition: .interpolate, speed: 0.01)
                    .font(.title)
                    .transition(.opacity)
//                    .padding(.trailing, 5)
//                HackerTextView(text: observed.currentProfile.name.isEmpty ?
//                     "Пользователь" : observed.currentProfile.name, trigger: trigger, transition: .interpolate, speed: 0.01)
//                .font(.title)
//                .transition(.opacity)
            }
        }
        .padding()
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
    
    private var greetingText: String {
        let name = observed.currentProfile.name.isEmpty ?
        "Пользователь" : observed.currentProfile.name
        
        let timeGreeting = getTimeDependentGreeting()
        return "\(timeGreeting), \(name)!"
    }
    
    private func getTimeDependentGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
            switch hour {
            case 6..<12: return "good_morning"
            case 12..<18: return "good_afternoon"
            case 18..<24: return "good_evening"
            default: return "good_night"
            }

    }
}

#Preview {
    HomeView()
}
