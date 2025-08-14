//
//  SidebarView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import SwiftUI

// The SidebarView provides the main navigation for the application.
// It's a key component for the desktop-first layout.
struct SidebarView: View {
    // A binding to the selectedRoute allows this view to update the main content view.
    @Binding var selectedRoute: NavigationRoute

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: - Header
            // The header of the sidebar, containing the app logo and name.
            HStack(spacing: 12) {
                Image(systemName: "graduationcap.fill")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.white.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                Text("Quizify")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(height: 80)
            .background(Color.quizifyDarkBackground.shadow(.inner(radius: 5, y: -5)))

            // MARK: - Navigation Menu
            // The list of navigation items.
            VStack(alignment: .leading, spacing: 8) {
                Text("STUDENT PORTAL")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 10)

                // Loop through all defined navigation routes.
                ForEach(NavigationRoute.allCases) { route in
                    SidebarButton(
                        route: route,
                        isSelected: selectedRoute == route,
                        action: { selectedRoute = route }
                    )
                }
            }
            .padding(.horizontal, 12)

            Spacer()

            // MARK: - Footer (Profile Section)
            // A quick access profile link at the bottom of the sidebar.
            VStack(spacing: 15) {
                Divider().background(Color.gray.opacity(0.3))
                
                Button(action: { selectedRoute = .profile }) {
                    HStack(spacing: 12) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                        VStack(alignment: .leading) {
                            Text("John Smith")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text("View Profile")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, 12)
                .padding(.bottom, 20)
            }
        }
        // Fixed width for the sidebar, crucial for a stable desktop layout.
        .frame(width: 280)
        .background(Color.quizifyDarkBackground)
    }
}

// A reusable button component for the sidebar items.
struct SidebarButton: View {
    let route: NavigationRoute
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Image(systemName: route.icon)
                    .font(.system(size: 20))
                    .frame(width: 24)
                Text(route.rawValue)
                    .font(.headline)
                    .fontWeight(.medium)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            // Visual feedback for the selected item.
            .background(isSelected ? Color.quizifyPrimary.opacity(0.8) : .clear)
            .foregroundColor(isSelected ? .white : .gray)
            .cornerRadius(8)
            .contentShape(Rectangle()) // Ensures the whole area is tappable
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Defines the navigation routes, their names, and associated icons.
// This enum makes the navigation logic clean and easy to manage.
enum NavigationRoute: String, CaseIterable, Identifiable {
    case dashboard = "Dashboard"
    case classes = "Classes"
    case tests = "Tests"
    case results = "Results"
    case profile = "Profile"
    case settings = "Settings"

    var id: String { self.rawValue }

    var icon: String {
        switch self {
        case .dashboard: return "square.grid.2x2.fill"
        case .classes: return "books.vertical.fill"
        case .tests: return "pencil.and.ruler.fill"
        case .results: return "chart.bar.xaxis"
        case .profile: return "person.fill"
        case .settings: return "gearshape.fill"
        }
    }
}

// Preview for the SidebarView.
struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView(selectedRoute: .constant(.dashboard))
    }
}
