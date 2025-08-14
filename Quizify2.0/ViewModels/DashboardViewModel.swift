//
//  DashboardViewModel.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import Foundation
import Combine

// This ViewModel is responsible for loading data for the DashboardView.
class DashboardViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    @Published var upcomingTests: [Test] = []
    @Published var classProgress: [Course] = []

    init() {
        // Load all necessary data when the ViewModel is created.
        self.activities = load("activities")
        
        let testData: TestDataSet = load("tests")
        self.upcomingTests = Array(testData.upcoming.prefix(3)) // Show first 3 upcoming tests
        
        let courseData: CourseDataSet = load("classes")
        self.classProgress = Array(courseData.active.prefix(4)) // Show progress for first 4 active classes
    }
}


//import Foundation
//import Combine
//
//// This ViewModel is responsible for loading data for the DashboardView.
//class DashboardViewModel: ObservableObject {
//    @Published var stats: [Stat] = []
//    @Published var activities: [Activity] = []
//    @Published var upcomingTests: [Test] = []
//    @Published var classProgress: [Course] = []
//
//    init() {
//        // Load all necessary data when the ViewModel is created.
//        self.stats = load("stats")
//        self.activities = load("activities")
//        
//        let testData: TestDataSet = load("tests")
//        self.upcomingTests = Array(testData.upcoming.prefix(3)) // Show first 3 upcoming tests
//        
//        let courseData: CourseDataSet = load("classes")
//        self.classProgress = Array(courseData.active.prefix(4)) // Show progress for first 4 active classes
//    }
//}
