//
//  ClassesViewModel.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import Foundation
import Combine

// This ViewModel manages the data for the ClassesView.
class ClassesViewModel: ObservableObject {
    @Published var activeClasses: [Course] = []
    @Published var completedClasses: [Course] = []

    init() {
        // Load class data from JSON.
        let courseData: CourseDataSet = load("classes")
        self.activeClasses = courseData.active
        self.completedClasses = courseData.completed
    }
}
