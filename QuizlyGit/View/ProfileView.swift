//
//  ProfileView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var name: String = ""
    var body: some View {
        NavigationStack{
            VStack(spacing: 9){
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .padding()
                TextField(" Ваше имя", text: $name)
                    .frame(height: 55)
                    .background(.gitOrange, in: RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 2))
                    .padding()
                
                Button(action: {
                    
                }, label:{
                    Text("Изменить пароль")
                })
                Spacer()
            }
            .navigationTitle("Настройки профиля")
            Section(""){
                
            }
        }
//        Text("Hello, World egere!")
    }
}

#Preview {
    ProfileView()
}
