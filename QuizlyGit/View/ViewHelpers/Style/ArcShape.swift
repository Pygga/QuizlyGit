//
//  ArcShape.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 31.05.2025.
//
import SwiftUI

struct ArcShape: Shape {
    var length: CGFloat
    var lineWidth: CGFloat
    var gap: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height) / 2 - lineWidth / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let arcAngle = radius == 0 ? 0 : (length / radius)
        let startAngle = -(arcAngle / 2)
        
        let circumference = 2 * .pi * radius
        let angleRatio = length / circumference
        let gapAngle = Angle.radians(-(gap / circumference) * 2 * .pi)
        
        let adjustedStartAngle = Angle.radians(startAngle) + gapAngle
        let adjustedEndAngle = Angle.radians(startAngle) + .radians(angleRatio * 2 * .pi) - gapAngle
        
        path.addArc(
            center: center,
            radius: radius,
            startAngle: adjustedStartAngle,
            endAngle: adjustedEndAngle,
            clockwise: true
        )
        
        return path
    }
}
