//
//  Category.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 03.05.2025.
//
import Foundation
import SwiftUICore

struct Category: Identifiable, Hashable {
    let id: String
    let name: String
    let iconName: String
    let color: Color
}
