//
//  ResultsViewModel.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import Foundation
import Combine

// This ViewModel is for the ResultsView, loading all result categories.
class ResultsViewModel: ObservableObject {
    @Published var recentResults: [TestResult] = []
    @Published var bestResults: [TestResult] = []
    @Published var allResults: [TestResult] = []

    init() {
        let resultsData: TestResultDataSet = load("results")
        self.recentResults = resultsData.recent
        self.bestResults = resultsData.best
        self.allResults = resultsData.all
    }
}
