//
//  StatCardView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

//import SwiftUI
//
//// A reusable card for displaying a key statistic.
//// It's designed to be flexible with customizable title, value, icon, and color.
//struct StatCardView: View {
//    let title: String
//    let value: String
//    let description: String
//    let icon: String
//    let trend: String
//    let color: Color
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            // MARK: - Card Header
//            HStack {
//                Text(title.uppercased())
//                    .font(.subheadline)
//                    .fontWeight(.bold)
//                    .foregroundColor(.quizifyTextGray)
//                Spacer()
//                Image(systemName: icon)
//                    .font(.title)
//                    .foregroundColor(.white)
//                    .frame(width: 48, height: 48)
//                    .background(color)
//                    .cornerRadius(12)
//            }
//
//            // MARK: - Main Value
//            Text(value)
//                .font(.system(size: 44, weight: .bold))
//                .foregroundColor(color)
//
//            // MARK: - Description and Trend
//            Text(description)
//                .font(.headline)
//                .foregroundColor(.quizifyTextGray)
//            
//            Spacer()
//            
//            Text(trend)
//                .font(.subheadline)
//                .fontWeight(.medium)
//                .foregroundColor(color)
//        }
//        .padding(20)
//        .frame(minHeight: 180) // Ensures all cards have a consistent height
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//struct StatCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        StatCardView(
//            title: "Active Classes",
//            value: "5",
//            description: "You are currently enrolled in 5 classes.",
//            icon: "books.vertical.fill",
//            trend: "+1 this semester",
//            color: .quizifyPrimary
//        )
//        .padding()
//        .background(Color.quizifyOffWhite)
//    }
//}


import SwiftUI

// A reusable card for displaying a key statistic.
// This version has been refined with smaller fonts and a more compact layout
// for a more professional appearance on desktop screens.
struct StatCardView: View {
    let title: String
    let value: String
    let description: String
    let icon: String
    let trend: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // MARK: - Card Header
            HStack {
                Text(title.uppercased())
                    .font(.caption) // Reduced from .subheadline
                    .fontWeight(.bold)
                    .foregroundColor(.quizifyTextGray)
                Spacer()
                Image(systemName: icon)
                    .font(.title2) // Reduced from .title
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44) // Reduced from 48
                    .background(color)
                    .cornerRadius(12)
            }

            // MARK: - Main Value
            Text(value)
                .font(.system(size: 36, weight: .bold)) // Reduced from 44
                .foregroundColor(color)

            // MARK: - Description and Trend
            Text(description)
                .font(.subheadline) // Reduced from .headline
                .foregroundColor(.quizifyTextGray)
            
            Spacer()
            
            Text(trend)
                .font(.caption) // Reduced from .subheadline
                .fontWeight(.medium)
                .foregroundColor(color)
        }
        .padding(15) // Reduced from 20
        .frame(minHeight: 160) // Reduced from 180
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

struct StatCardView_Previews: PreviewProvider {
    static var previews: some View {
        StatCardView(
            title: "Active Classes",
            value: "5",
            description: "You are currently enrolled in 5 classes.",
            icon: "books.vertical.fill",
            trend: "+1 this semester",
            color: .quizifyPrimary
        )
        .padding()
        .background(Color.quizifyOffWhite)
    }
}


//import SwiftUI
//
//// A reusable card for displaying a key statistic.
//// It is now driven by a 'Stat' data model and has refined internal spacing.
//struct StatCardView: View {
//    let stat: Stat
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            // MARK: - Card Header
//            HStack {
//                Text(stat.title.uppercased())
//                    .font(.caption)
//                    .fontWeight(.bold)
//                    .foregroundColor(.quizifyTextGray)
//                Spacer()
//                Image(systemName: stat.icon)
//                    .font(.title2)
//                    .foregroundColor(.white)
//                    .frame(width: 44, height: 44)
//                    .background(stat.themeColor)
//                    .cornerRadius(12)
//            }
//
//            // MARK: - Main Value
//            Text(stat.value)
//                .font(.system(size: 36, weight: .bold))
//                .foregroundColor(stat.themeColor)
//
//            // MARK: - Description and Trend
//            // The Spacer has been removed to reduce the vertical gap.
//            VStack(alignment: .leading, spacing: 4) {
//                Text(stat.description)
//                    .font(.subheadline)
//                    .foregroundColor(.quizifyTextGray)
//                
//                Text(stat.trend)
//                    .font(.caption)
//                    .fontWeight(.medium)
//                    .foregroundColor(stat.themeColor)
//            }
//        }
//        .padding(15)
//        .frame(minHeight: 160, alignment: .top) // Align content to the top
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
