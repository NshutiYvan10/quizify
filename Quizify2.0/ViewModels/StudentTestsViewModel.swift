//
//  StudentTestsViewModel.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 12/08/2025.
//

//import Foundation
//import Combine
//
//// This ViewModel manages the data for the student's TestsView.
//class StudentTestsViewModel: ObservableObject {
//    @Published var upcomingTests: [StudentTest] = []
//    @Published var completedTests: [StudentTest] = []
//    @Published var missedTests: [StudentTest] = []
//
//    init() {
//        // Load all test categories from the tests.json file.
//        let testData: StudentTestDataSet = load("tests")
//        self.upcomingTests = testData.upcoming
//        self.completedTests = testData.completed
//        self.missedTests = testData.missed
//    }
//}

import Foundation
import Combine

// This ViewModel manages the data for the student's TestsView.
class StudentTestsViewModel: ObservableObject {
    @Published var upcomingTests: [Test] = []
    @Published var completedTests: [Test] = []
    @Published var missedTests: [Test] = []

    init() {
        // Load all test categories from the tests.json file.
        let testData: StudentTestDataSet = load("tests")
        self.upcomingTests = testData.upcoming
        self.completedTests = testData.completed
        self.missedTests = testData.missed
    }
}
