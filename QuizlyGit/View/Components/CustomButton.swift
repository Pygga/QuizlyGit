//
//  CustomButton.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 30.04.2025.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> ()
    var body: some View {
        Button(title, action: action)
            .frame(maxWidth: .infinity, maxHeight: 57)
            .tint(.white)
            .font(.title3)
            .fontWeight(.light)
            .background(.gitOrange, in: RoundedRectangle(cornerRadius: 14))
    }
}

//#Preview {
//    CustomButton(title: "Войти", action: {})
//}
