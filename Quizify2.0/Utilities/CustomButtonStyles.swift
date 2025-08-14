//
//  CustomButtonStyles.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 14/08/2025.
//

import SwiftUI

// A custom button style for filled, prominent buttons with a shadow effect.
struct FilledButtonStyle: ButtonStyle {
    var color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .shadow(color: color.opacity(0.4), radius: configuration.isPressed ? 5 : 10, y: 5)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// A custom button style for outlined buttons.
struct OutlineButtonStyle: ButtonStyle {
    var color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(color)
            .background(Color.clear)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(color, lineWidth: 1.5)
            )
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
