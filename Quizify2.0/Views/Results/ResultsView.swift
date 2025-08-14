//
//  ResultsView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import SwiftUI

// The ResultsView shows a detailed breakdown of the user's test scores.
// It uses a tabbed interface to filter results.
struct ResultsView: View {
    // The ViewModel provides the test result data.
    @StateObject private var viewModel = ResultsViewModel()
    // State to manage the currently selected tab.
    @State private var selectedTab: ResultTab = .recent

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // MARK: - Header and Tab Picker
                HStack {
                    VStack(alignment: .leading) {
                        Text("My Results")
                            .font(.system(size: 28, weight: .bold))
                        Text("View your test results and performance analytics.")
                            .font(.title3)
                            .foregroundColor(.quizifyTextGray)
                    }
                    Spacer()
                    Picker("Filter Results", selection: $selectedTab) {
                        ForEach(ResultTab.allCases) { tab in
                            Text(tab.rawValue).tag(tab)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: 400)
                }
                
                // MARK: - Performance Summary
                // A grid of stat cards summarizing overall performance.
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 25)], spacing: 25) {
                    StatCardView(title: "Average Score", value: "87%", description: "Across all tests", icon: "percent", trend: "+2% from last month", color: .quizifyPrimary)
                    StatCardView(title: "Tests Completed", value: "24", description: "Out of 25 assigned", icon: "checkmark.circle.fill", trend: "96% completion rate", color: .quizifyAccentBlue)
                    StatCardView(title: "Best Subject", value: "English", description: "95% average score", icon: "star.fill", trend: "Consistent performance", color: .quizifyAccentGreen)
                }
                .padding(.bottom, 10)


                // MARK: - Results List
                // The list of result cards, filtered by the selected tab.
                VStack(spacing: 20) {
                    let results = currentResults()
                    if results.isEmpty {
                        Text("No results to display in this category.")
                            .foregroundColor(.gray)
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 200)
                    } else {
                        ForEach(results) { result in
                            ResultCardView(result: result)
                        }
                    }
                }
            }
            .padding(30)
        }
    }
    
    // Helper function to return the correct data based on the selected tab.
    private func currentResults() -> [TestResult] {
        switch selectedTab {
        case .recent:
            return viewModel.recentResults
        case .best:
            return viewModel.bestResults
        case .all:
            return viewModel.allResults
        }
    }
}

// Enum to define the filter tabs for the results.
enum ResultTab: String, CaseIterable, Identifiable {
    case recent = "Recent"
    case best = "Best Scores"
    case all = "All Results"
    var id: String { self.rawValue }
}

// MARK: - ResultCardView
// A card for displaying the details of a single test result.
struct ResultCardView: View {
    let result: TestResult
    
    // Determines the color based on the score for visual feedback.
    private var scoreColor: Color {
        if result.score >= 90 { return .quizifyAccentGreen }
        if result.score >= 80 { return .quizifyAccentBlue }
        if result.score >= 70 { return .quizifyAccentYellow }
        return .quizifyRedError
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // MARK: Card Header
            HStack {
                VStack(alignment: .leading) {
                    Text(result.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(result.subject)
                        .font(.headline)
                        .foregroundColor(.quizifyTextGray)
                }
                Spacer()
                Text(result.date)
                    .font(.subheadline)
                    .foregroundColor(.quizifyTextGray)
            }
            
            Divider()
            
            // MARK: Score Details
            HStack {
                // Score
                VStack {
                    Text("Score")
                        .font(.caption)
                        .foregroundColor(.quizifyTextGray)
                    Text("\(result.score)%")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(scoreColor)
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                
                // Correct Answers
                VStack {
                    Text("Correct")
                        .font(.caption)
                        .foregroundColor(.quizifyTextGray)
                    Text("\(result.correct)/\(result.total)")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                
                Divider()

                // Class Average
                VStack {
                    Text("Class Avg.")
                        .font(.caption)
                        .foregroundColor(.quizifyTextGray)
                    Text("\(result.classAverage)%")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
            }
            
            Divider()
            
            // MARK: Card Footer
            HStack {
                Label(result.teacher, systemImage: "person.fill")
                    .font(.subheadline)
                Spacer()
                Button(action: {}) {
                    Label("View Details", systemImage: "eye.fill")
                }
                .buttonStyle(.bordered)
                .tint(scoreColor)
            }
            .foregroundColor(.quizifyTextGray)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

// MARK: - Preview
struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
