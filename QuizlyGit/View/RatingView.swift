//
//  RatingView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 07.05.2025.
//

import SwiftUI

struct RatingView: View {
    @State private var progress: Double? = nil
    @StateObject private var viewModel = LeaderboardViewModel()
    @EnvironmentObject var localization: LocalizationManager
    
    @State private var isFirstUserVisible = false
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoadingRingView(text: "Загрузка", progress: $progress)
            } else {
                content
            }
        }
        .navigationTitle(LocalizedStringKey("rating"))
        .onAppear { viewModel.loadLeaderboard() }
        //Для смены локализации
        .environment(\.locale, .init(identifier: localization.currentLanguage))
    }
    
    private var content: some View {
        ScrollView {
            // Секция подиума
            PodiumView(users: Array(viewModel.users.prefix(3)))
                .padding(.vertical, 40)

            LazyVStack(spacing: 16){
                ForEach(viewModel.users.dropFirst(3)) { user in
                    RegularUserView(user: user)
                }
            }
            .padding()

        }
        .scrollIndicators(.hidden)
        .toolbar{
            ToolbarItem(placement: .bottomBar) {
                CurrentUserPositionView(position: viewModel.currentUserPosition)
            }
        }
    }
}

// MARK: - Компоненты
private struct PodiumView: View {
    let users: [LeaderboardUser]
    @Environment(\.colorScheme) var colorScheme
    @State private var isFirstUserVisible = false
    var body: some View {
        ZStack {
            // Фон карточки с обрезанием содержимого
            RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme == .dark ? .themeBG : .white)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
                .frame(height: 360)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(.systemGray3), lineWidth: 1)
                )
                .padding(.horizontal, 10)
            
            // Контент подиума
            HStack(alignment: .bottom, spacing: 0) {
                podiumColumn(user: users[safe: 1], height: 180)
                podiumColumn(user: users[safe: 0], height: 220)
                    .padding(.horizontal, 20)
                podiumColumn(user: users[safe: 2], height: 160)
            }
            .padding(.horizontal, 30)
            .padding(.top, 40)
        }
        .padding(.horizontal)
        .frame(height: 320)
    }
    
    private func podiumColumn(user: LeaderboardUser?, height: CGFloat) -> some View {
        ZStack(alignment: .bottom) {
            // Подиумная ступень
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.systemGray5),
                        Color(.systemGray4)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .frame(height: height)
                .overlay(
                    Text(user?.position.ordinalString ?? "")
                        .font(.title.bold())
                        .foregroundColor(.primary)
                        .offset(y: -24)
                )
            
            // Контент пользователя
            if let user = user {
                VStack(spacing: 8) {
                    userAvatar(user)
                        .padding(.bottom, height - 80)
                    
                    VStack(spacing: 4) {
                        Text(user.name)
                            .font(.headline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                        Text(String(user.totalScore))
                            .font(.subheadline.bold())
                            .foregroundColor(scoreColor(for: user.position))

                        Text(LocalizedStringKey("points"))
                            .font(.subheadline.bold())
                            .foregroundColor(scoreColor(for: user.position))
                    }
                }
                .padding(.bottom, 20)
            }
        }
        .frame(width: 100)
    }
    
    private func userAvatar(_ user: LeaderboardUser) -> some View {
        ZStack(alignment: .top) {
            AsyncImage(url: user.avatarURL) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .foregroundColor(.gray)
            }
            .scaledToFill()
            .frame(width: 80, height: 80)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(borderColor(for: user.position), lineWidth: 3)
                    .shadow(color: borderColor(for: user.position), radius: 10, x: 0, y: 0)
            )
            .zIndex(1)
            
            if user.position == 1 {
                Image(systemName: "crown.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.yellow)
                    .offset(y: -30)
                    .shadow(color: .yellow.opacity(0.5), radius: 10, x: 0, y: 0)
            }
        }
    }
    
    // MARK: - Стили
    private func borderColor(for position: Int) -> Color {
        switch position {
        case 1: return .yellow
        case 2: return .gray.opacity(0.8)
        case 3: return .orange
        default: return .clear
        }
    }
    
    private func scoreColor(for position: Int) -> Color {
        switch position {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .primary
        }
    }
}

private struct TopThreeUserView: View {
    let user: LeaderboardUser
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            if user.position == 1 {
                Image(systemName: "crown.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.yellow)
                    .offset(y: -99)
                    .zIndex(1)
            }
            
            VStack(spacing: 4) {
                AsyncImage(url: user.avatarURL) { image in
                    image.resizable()
                } placeholder: {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                }
                .scaledToFill()
                .frame(width: avatarSize, height: avatarSize)
                .clipShape(Circle())
                .overlay(Circle().stroke(borderColor, lineWidth: 3))
                .padding(.bottom, 20)
                
                Text(user.name)
                    .font(.headline)
                HStack{
                    Text(String(user.totalScore))
                    Text(LocalizedStringKey("points"))
                }
                .font(.subheadline.bold())
                .foregroundColor(scoreColor)
                
                Text(user.rank.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(width: cardWidth)
            .background(backgroundColor)
            .cornerRadius(20)
            .shadow(color: shadowColor, radius: 10, x: 0, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(.systemGray3), lineWidth: 1)
            )
        }
        .padding(.top, 5)
    }
    
    private var avatarSize: CGFloat {
        switch user.position {
        case 1: return 90
        case 2: return 80
        case 3: return 70
        default: return 60
        }
    }
    
    private var cardWidth: CGFloat {
        switch user.position {
        case 1: return 280
        case 2: return 260
        case 3: return 240
        default: return 220
        }
    }
    
    private var borderColor: Color {
        switch user.position {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .clear
        }
    }
    
    private var scoreColor: Color {
        switch user.position {
        case 1: return .yellow
        case 2: return .gray
        case 3: return .orange
        default: return .primary
        }
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? Color(.systemGray6) : .white
    }
    
    private var shadowColor: Color {
        switch user.position {
        case 1: return .yellow.opacity(0.3)
        case 2: return .gray.opacity(0.3)
        case 3: return .orange.opacity(0.3)
        default: return .clear
        }
    }
}

private struct RegularUserView: View {
    let user: LeaderboardUser
    
    var body: some View {
        HStack(spacing: 16) {
            Text("\(user.position)")
                .font(.headline)
                .frame(width: 30)
            
            AsyncImage(url: user.avatarURL) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.subheadline)
                Text(user.rank.rawValue)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text("\(user.totalScore)")
                .font(.subheadline.bold())
        }
        .padding()
        .background(.themeBG)
        .cornerRadius(12)
        .shadow(radius: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray3), lineWidth: 1)
        )
        .padding(.horizontal, 10)
    }
}

private struct CurrentUserPositionView: View {
    let position: Int
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(LocalizedStringKey("place"))
                    .font(.subheadline)
                
                Text("#\(position)")
                    .font(.title3.bold())
                    .foregroundColor(.blue)
            }
            .padding(.vertical)
        }
        .padding(.horizontal)
    }
}

#Preview {
    RatingView()
}
