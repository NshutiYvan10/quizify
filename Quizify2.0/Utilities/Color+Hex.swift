//
//  Color+Hex.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import SwiftUI

// This extension allows creating SwiftUI Color objects from a hexadecimal string,
// which is how colors are defined in your JSON data. This is crucial for
// dynamically styling your components based on the data.
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0) // Default to black
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    // Define your app's color palette as static properties for easy access.
    // This makes it simple to maintain a consistent look and feel.
    static let quizifyPrimary = Color(hex: "#5D4ED6")
    static let quizifyAccentYellow = Color(hex: "#FDBD41")
    static let quizifyAccentBlue = Color(hex: "#00B6B6")
    static let quizifyAccentGreen = Color(hex: "#22C870")
    static let quizifyRedError = Color(hex: "#E03F4D")
    static let quizifyDarkBackground = Color(hex: "#111326")
    static let quizifyTextGray = Color(hex: "#6B7280")
    static let quizifyLightGray = Color(hex: "#D1D5DB")
    static let quizifyOffWhite = Color(hex: "#F9FAFB")
}
