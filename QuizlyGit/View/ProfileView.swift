//
//  ProfileView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        Form {
            Section(header: Text("Основная информация")) {
                HStack {
                    if let image = viewModel.avatarImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                    } else {
                        AsyncImage(url: viewModel.currentUser.avatarURL) { image in
                            image.resizable()
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    }
                    
                    Button("Изменить фото") {
                        viewModel.showImagePicker.toggle()
                    }
                }
                
                TextField("Новое имя", text: $viewModel.newName)
                Button("Сохранить имя") {
                    Task { await viewModel.updateName() }
                }
            }
            
            Section(header: Text("Безопасность")) {
                SecureField("Текущий пароль", text: $viewModel.currentPassword)
                SecureField("Новый пароль", text: $viewModel.newPassword)
                Button("Сменить пароль") {
                    Task { await viewModel.changePassword() }
                }
            }
            
            Section {
                Button("Удалить аккаунт", role: .destructive) {
                    viewModel.deleteAccount()
                }
            }
        }
        .navigationTitle("Редактирование профиля")
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(image: $viewModel.avatarImage)
        }
        .onChange(of: viewModel.avatarImage) { _ in
            Task { await viewModel.updateAvatar() }
        }
    }
}
