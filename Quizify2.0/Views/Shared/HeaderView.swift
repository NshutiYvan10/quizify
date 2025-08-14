//
//  HeaderView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

//import SwiftUI
//
//// The HeaderView appears at the top of the main content area.
//// It contains the current page title, a search bar, and user actions.
//struct HeaderView: View {
//    @State private var searchText = ""
//    // The selectedRoute is passed in to display the correct title.
//    @Binding var selectedRoute: NavigationRoute
//    
//    // Formats the current date for display.
//    private var currentDate: String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEEE, MMMM d, yyyy"
//        return formatter.string(from: Date())
//    }
//
//    var body: some View {
//        HStack(spacing: 20) {
//            // MARK: - Page Title
//            Text(selectedRoute.rawValue)
//                .font(.system(size: 32, weight: .bold))
//
//            Spacer()
//            
//            // MARK: - Search Bar
//            // A functional search bar, styled for a desktop app.
//            HStack {
//                Image(systemName: "magnifyingglass")
//                    .foregroundColor(.gray)
//                TextField("Search anything...", text: $searchText)
//                    .textFieldStyle(PlainTextFieldStyle())
//                    .font(.title3)
//            }
//            .padding(12)
//            .background(Color.white)
//            .cornerRadius(10)
//            .overlay(
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.quizifyLightGray, lineWidth: 1)
//            )
//            .frame(maxWidth: 350)
//
//            // MARK: - Date and Action Buttons
//            Text(currentDate)
//                .font(.headline)
//                .foregroundColor(.quizifyTextGray)
//            
//            HStack(spacing: 20) {
//                // Notification button with a badge.
//                ZStack {
//                    Button(action: {}) {
//                        Image(systemName: "bell.fill")
//                            .font(.title2)
//                            .foregroundColor(.quizifyTextGray)
//                    }
//                    .buttonStyle(PlainButtonStyle())
//                    
//                    Text("3")
//                        .font(.caption2)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .frame(width: 18, height: 18)
//                        .background(Color.quizifyRedError)
//                        .clipShape(Circle())
//                        .offset(x: 10, y: -10)
//                }
//                
//                // Settings button that navigates to the settings page.
//                Button(action: { selectedRoute = .settings }) {
//                    Image(systemName: "gearshape.fill")
//                        .font(.title2)
//                        .foregroundColor(.quizifyTextGray)
//                }
//                .buttonStyle(PlainButtonStyle())
//            }
//        }
//        .padding(.horizontal, 30)
//        .padding(.vertical, 20)
//        .frame(height: 80)
//        // A subtle shadow gives the header depth.
//        .background(Color.white.shadow(.drop(color: .black.opacity(0.05), radius: 5, y: 5)))
//    }
//}
//
//struct HeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeaderView(selectedRoute: .constant(.dashboard))
//    }
//}


import SwiftUI

// The HeaderView appears at the top of the main content area.
// It contains the current page title, a search bar, and user actions.
struct HeaderView: View {
    @State private var searchText = ""
    // The selectedRoute is passed in to display the correct title.
    @Binding var selectedRoute: NavigationRoute
    
    // Formats the current date for display.
    private var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d, yyyy"
        return formatter.string(from: Date())
    }

    var body: some View {
        HStack(spacing: 20) {
            // MARK: - Page Title
            Text(selectedRoute.rawValue)
                .font(.system(size: 28, weight: .bold))

            Spacer()
            
            // MARK: - Search Bar
            // A functional search bar, styled for a desktop app.
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search anything...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.title3)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8) // Reduced vertical padding
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.quizifyLightGray, lineWidth: 1)
            )
            .frame(maxWidth: 350)

            // MARK: - Date and Action Buttons
            Text(currentDate)
                .font(.headline)
                .foregroundColor(.quizifyTextGray)
            
            HStack(spacing: 20) {
                // Notification button with a badge.
                ZStack {
                    Button(action: {}) {
                        Image(systemName: "bell.fill")
                            .font(.title2)
                            .foregroundColor(.quizifyTextGray)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Text("3")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 18, height: 18)
                        .background(Color.quizifyRedError)
                        .clipShape(Circle())
                        .offset(x: 10, y: -10)
                }
                
                // Settings button that navigates to the settings page.
                Button(action: { selectedRoute = .settings }) {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                        .foregroundColor(.quizifyTextGray)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 30)
        .frame(height: 64) // Reduced height for a more professional look
        // A subtle shadow gives the header depth.
        .background(Color.white.shadow(.drop(color: .black.opacity(0.05), radius: 5, y: 5)))
    }
}
