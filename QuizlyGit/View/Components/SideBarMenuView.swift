//
//  SideBarMenuView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//

import SwiftUI

struct SideBarMenuView: View {
    @AppStorage("log_status") var logStatus: Bool = false
    @State var safeArea: UIEdgeInsets
    @Binding var selectedTab: Tab
    var closeMenu: () -> Void
    
    var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("Меню")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 10)
                ForEach(Tab.allCases.filter { $0 != .logout }, id: \.self) { tab in
                                SideBarButton(tab) {
                                    selectedTab = tab
                                    closeMenu()
                                }
                            }
                
                Spacer(minLength: 0)
                
                SideBarButton(.logout) {
                    selectedTab = .logout
                    closeMenu()
                    logStatus = false
                }
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 20)
            .padding(.top, safeArea.top)
            .padding(.bottom, safeArea.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .environment(\.colorScheme, .dark)
        }
    
    @ViewBuilder
    func SideBarButton(_ tab: Tab, onTap: @escaping () -> Void) -> some View{
        Button(action: onTap, label:{
            HStack(spacing: 12){
                Image(systemName: tab.rawValue)
                    .font(.title3)
                
                Text(tab.title)
                    .font(.callout)
                
                Spacer(minLength: 0)
            }
            .padding(.vertical, 10)
            .contentShape(.rect)
            .foregroundStyle(Color.primary)
        })
    }
}

//Пока что так
enum Tab: String, CaseIterable {
    case home = "gamecontroller.fill"
    case profile = "person.circle.fill"
    case statistics = "chart.bar.fill"
    case settings = "gearshape.fill"
    case logout = "rectangle.portrait.and.arrow.forward.fill"
    
    var title: String {
        switch self {
            
        case .home: return "Играть"
        case .profile: return "Профиль"
        case .statistics: return "Статистика"
        case .settings: return "Настройки"
        case .logout: return "Выход"
        }
    }
}

