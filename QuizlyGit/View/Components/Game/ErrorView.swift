//
//  ErrorView.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 01.05.2025.
//
import SwiftUI

struct ErrorView: View {
    let message: String
    @Environment(\.dismiss) private var dismiss
    var retryAction: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text("Ошибка")
                .font(.title)
                .bold()
            
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            if let retry = retryAction {
                Button(action: retry) {
                    Text("Повторить попытку")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
//            NavigationLink(destination: HomeView()) {
//                Text("На главную")
//                    .padding()
//                    .background(Color.gray.opacity(0.2))
//                    .foregroundColor(.primary)
//                    .cornerRadius(10)
//            }
            Button("Назад") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}
