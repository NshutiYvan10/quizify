//
//  MainView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import SwiftUI

// This is the root view that holds the entire application's UI.
// It sets up the main layout with a sidebar and a content area.
struct MainView: View {
    // @State to track the currently selected navigation route.
    @State private var selectedRoute: NavigationRoute = .dashboard

    var body: some View {
        HStack(spacing: 0) {
            // The persistent sidebar for navigation.
            SidebarView(selectedRoute: $selectedRoute)

            // The main content area that changes based on the selected route.
            VStack(spacing: 0) {
                HeaderView(selectedRoute: $selectedRoute)
                
                // The content view is determined by the 'contentForRoute' helper.
                contentForRoute(selectedRoute)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    // A consistent background for all content pages.
                    .background(Color.quizifyOffWhite)
            }
        }
        // A minimum window size appropriate for an iMac display.
        .frame(minWidth: 1400, minHeight: 900)
        .background(Color.quizifyDarkBackground)
    }

    // This @ViewBuilder function returns the correct view based on the selected route.
    // This is a clean way to handle navigation logic in the main view.
    @ViewBuilder
    private func contentForRoute(_ route: NavigationRoute) -> some View {
        switch route {
        case .dashboard:
            DashboardView()
        case .classes:
            ClassesView()
        case .tests:
            TestsView()
        case .results:
            ResultsView()
        case .profile:
            ProfileView()
        case .settings:
            SettingsView()
        }
    }
}

// Preview provider for Xcode Previews.
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
