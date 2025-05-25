//
//  CustomTextField.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 30.04.2025.
//

import SwiftUI

struct CustomTextField: View {
    let isSecure: Bool
    let title: String
    @Binding var text: String
    @FocusState var isTyping: Bool
    @State private var isSecureField: Bool
    
    init(isSecure: Bool, title: String, text: Binding<String>) {
        self.isSecure = isSecure
        self.title = title
        self._text = text
        self.isSecureField = isSecure
    }
    
    var body: some View {
            if isSecureField {
                ZStack(alignment: .leading){
                    HStack{
                        SecureField("", text: $text).padding(.leading)
                        
                        if isSecure{
                            Button(action:{
                                isSecureField.toggle()
                            }){
                                Image(systemName: isSecureField ? "eye.fill" : "eye.slash.fill")
                                    .resizable()
                                    .frame(width: 26.5, height: 16.5)
                            }
                            .padding(.trailing, 2)
                            .tint(.gitOrange)
                        }
                    }
                    Text(title).padding(.horizontal, 5)
                        .frame(height: 10)
                        .background(.colorBG.opacity(isTyping || !text.isEmpty ? 1 : 0))
                        .foregroundStyle(isTyping ? .gitOrange : Color.primary)
                        .padding(.leading).offset(y: isTyping || !text.isEmpty ? -27 : 0)
                        .onTapGesture {
                            isTyping.toggle()
                        }
                }
                .frame(height: 55).focused($isTyping)
                .background(isTyping ? .gitOrange : Color.primary, in: RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 2))
                .animation(.linear(duration: 0.2), value: isTyping)
                
            } else {
                ZStack(alignment: .leading){
                    HStack{
                        TextField("", text: $text).padding(.leading)
                        if isSecure{
                            Button(action:{
                                isSecureField.toggle()
                            }){
                                Image(systemName: isSecureField ? "eye.fill" : "eye.slash.fill")
                                    .resizable()
                                    .frame(width: 26.5, height: 16.5)
                            }
                            .padding(.trailing, 2)
                            .tint(.gitOrange)
                        }
                    }
                    Text(title).padding(.horizontal, 5)
                        .frame(height: 10)
                        .background(.colorBG.opacity(isTyping || !text.isEmpty ? 1 : 0))
                        .foregroundStyle(isTyping ? .gitOrange : Color.primary)
                        .padding(.leading).offset(y: isTyping || !text.isEmpty ? -27 : 0)
                        .onTapGesture {
                            isTyping.toggle()
                        }
                }
                .frame(height: 55).focused($isTyping)
                .background(isTyping ? .gitOrange : Color.primary, in: RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 2))
                .animation(.linear(duration: 0.2), value: isTyping)
            }
    }
}
