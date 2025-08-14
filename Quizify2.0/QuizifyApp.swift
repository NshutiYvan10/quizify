//
//  QuizifyApp.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import SwiftUI

@main
struct QuizifyApp: App {
    var body: some Scene {
        WindowGroup {
            // The MainView is the root view of the application.
            MainView()
        }
        // Hides the default title bar for a cleaner, custom look.
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
