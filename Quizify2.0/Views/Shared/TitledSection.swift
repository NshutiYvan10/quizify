//
//  TitledSection.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

//import SwiftUI
//
//// A generic section view with a title and description.
//// This reusable component ensures consistent styling for sections across the app.
//struct TitledSection<Content: View>: View {
//    let title: String
//    let description: String
//    // @ViewBuilder allows passing multiple views as the content.
//    @ViewBuilder let content: Content
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            // Section header
//            VStack(alignment: .leading) {
//                Text(title)
//                    .font(.title2)
//                    .fontWeight(.bold)
//                Text(description)
//                    .font(.subheadline)
//                    .foregroundColor(.quizifyTextGray)
//            }
//            // The content passed to the section.
//            content
//        }
//        .padding(20)
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}


import SwiftUI

// A generic section view with a title, description, and an optional footer.
// This reusable component ensures consistent styling for sections across the app.
struct TitledSection<Content: View, Footer: View>: View {
    let title: String
    let description: String
    @ViewBuilder let content: Content
    @ViewBuilder let footer: Footer

    // Initializer for sections with content and a footer.
    init(title: String, description: String, @ViewBuilder content: () -> Content, @ViewBuilder footer: () -> Footer) {
        self.title = title
        self.description = description
        self.content = content()
        self.footer = footer()
    }
    
    // Initializer for sections with only content (no footer).
    init(title: String, description: String, @ViewBuilder content: () -> Content) where Footer == EmptyView {
        self.init(title: title, description: description, content: content, footer: { EmptyView() })
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Section header
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.quizifyTextGray)
            }
            
            // The main content passed to the section.
            content
            
            // The optional footer content.
            footer
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}
