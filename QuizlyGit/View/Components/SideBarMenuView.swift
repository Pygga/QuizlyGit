//
//  SideBarMenuView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//

import SwiftUI

struct SideBarMenuView: View {
    @State var safeArea: UIEdgeInsets
    @Binding var selectedTab: Tab
    var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Text("Side Menu")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 10)
                SideBarButton(.home) { selectedTab = .home }
                SideBarButton(.profile){ selectedTab = .profile }
                SideBarButton(.statistics) { selectedTab = .statistics }
                SideBarButton(.settings) { selectedTab = .settings }
                
                Spacer(minLength: 0)
                
                SideBarButton(.logout) { selectedTab = .settings }
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
    case home = "house.fill"
    case statistics = "chart.bar.fill"
    case settings = "gearshape.fill"
    case profile = "person.circle.fill"
    case logout = "rectangle.portrait.and.arrow.forward.fill"
    
    var title: String {
        switch self {
            
        case .home: return "Home"
        case .profile: return "Profile"
        case .statistics: return "Statistics"
        case .settings: return "Settings"
        case .logout: return "Выход"
        }
    }
}

