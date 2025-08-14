//
//  TestsViewModel.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import Foundation
import Combine

// This ViewModel handles the data for the TestsView.
class TestsViewModel: ObservableObject {
    @Published var upcomingTests: [Test] = []
    @Published var completedTests: [Test] = []
    @Published var missedTests: [Test] = []

    init() {
        // Load all test categories from JSON.
        let testData: TestDataSet = load("tests")
        self.upcomingTests = testData.upcoming
        self.completedTests = testData.completed
        self.missedTests = testData.missed
    }
}
