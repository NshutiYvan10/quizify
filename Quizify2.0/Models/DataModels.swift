//
//  DataModels.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

//import Foundation
//import SwiftUI
//
//// MARK: - Generic JSON Loader
//// This helper function loads and decodes JSON data from the app bundle.
//func load<T: Decodable>(_ filename: String) -> T {
//    let data: Data
//
//    guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
//        fatalError("Couldn't find \(filename) in main bundle.")
//    }
//
//    do {
//        data = try Data(contentsOf: file)
//    } catch {
//        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//    }
//
//    do {
//        let decoder = JSONDecoder()
//        return try decoder.decode(T.self, from: data)
//    } catch {
//        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//    }
//}
//
//// MARK: - Activity Model (for Dashboard)
//struct Activity: Codable, Identifiable {
//    let id: String
//    let title: String
//    let description: String
//    let time: String
//    let icon: String
//    let iconBgColor: String
//
//    var color: Color {
//        Color(hex: iconBgColor)
//    }
//}
//
//// MARK: - Course (Class) Model
//struct Course: Codable, Identifiable, Hashable {
//    let id: Int
//    let name: String
//    let subject: String
//    let teacher: String
//    let teacherAvatar: String?
//    let students: Int
//    let duration: String
//    let schedule: String
//    let testsCompleted: Int
//    let totalTests: Int
//    let progress: Int
//    let status: String
//    let color: String
//    let coverImage: String
//    
//    var themeColor: Color {
//        Color(hex: color)
//    }
//}
//
//struct CourseDataSet: Codable {
//    let active: [Course]
//    let completed: [Course]
//}
//
//// MARK: - User Profile Model
//struct UserProfile: Codable, Identifiable {
//    let id: String
//    let name: String
//    let email: String
//    let phone: String
//    let address: String
//    let username: String
//    let grade: String
//    let school: String
//    let avatarUrl: String?
//    let totalQuizzes: Int
//    let quizzesCompleted: Int
//    let averageScore: Double
//    let badges: [String]
//    let activeClasses: [ProfileClass]
//    let performance: [SubjectPerformance]
//    let recentTests: [ProfileTest]
//}
//
//struct ProfileClass: Codable, Identifiable, Hashable {
//    let id: Int
//    let name: String
//    let teacher: String
//    let schedule: String
//    let grade: Int
//    let color: String
//    
//    var themeColor: Color {
//        Color(hex: color)
//    }
//}
//
//struct SubjectPerformance: Codable, Identifiable, Hashable {
//    let id: String
//    let name: String
//    let score: Int
//    let testsCompleted: Int
//    let totalTests: Int
//    let classAverage: Int
//}
//
//struct ProfileTest: Codable, Identifiable, Hashable {
//    let id: Int
//    let title: String
//    let `class`: String
//    let date: String
//    let score: Int
//}
//
//
//// MARK: - Test Result Model
//struct TestResult: Codable, Identifiable, Hashable {
//    let id: Int
//    let title: String
//    let subject: String
//    let className: String
//    let teacher: String
//    let teacherAvatar: String?
//    let date: String
//    let duration: String
//    let score: Int
//    let correct: Int
//    let total: Int
//    let classAverage: Int
//}
//
//struct TestResultDataSet: Codable {
//    let recent: [TestResult]
//    let best: [TestResult]
//    let all: [TestResult]
//}
//
//// MARK: - Test Model
//struct Test: Codable, Identifiable, Hashable {
//    let id: Int
//    let title: String
//    let subject: String
//    let className: String
//    let teacher: String
//    let teacherAvatar: String?
//    let classId: Int
//    let date: String
//    let time: String
//    let duration: String
//    let questions: Int
//    let status: String
//    var score: Int?
//}
//
//struct TestDataSet: Codable {
//    let upcoming: [Test]
//    let completed: [Test]
//    let missed: [Test]
//}


import Foundation
import SwiftUI

// MARK: - Generic JSON Loader
// This helper function loads and decodes JSON data from the app bundle.
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

// MARK: - Stat Card Model (for Dashboard)
struct Stat: Codable, Identifiable {
    let id: String
    let title: String
    let value: String
    let description: String
    let icon: String
    let trend: String
    let color: String

    var themeColor: Color {
        Color(hex: color)
    }
}

// MARK: - Activity Model (for Dashboard)
struct Activity: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let time: String
    let icon: String
    let iconBgColor: String

    var color: Color {
        Color(hex: iconBgColor)
    }
}

// MARK: - Course (Class) Model
struct Course: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let subject: String
    let teacher: String
    let teacherAvatar: String?
    let students: Int
    let duration: String
    let schedule: String
    let testsCompleted: Int
    let totalTests: Int
    let progress: Int
    let status: String
    let color: String
    let coverImage: String
    
    var themeColor: Color {
        Color(hex: color)
    }
}

struct CourseDataSet: Codable {
    let active: [Course]
    let completed: [Course]
}

// MARK: - User Profile Model
struct UserProfile: Codable, Identifiable {
    let id: String
    let name: String
    let email: String
    let phone: String
    let address: String
    let username: String
    let grade: String
    let school: String
    let avatarUrl: String?
    let totalQuizzes: Int
    let quizzesCompleted: Int
    let averageScore: Double
    let badges: [String]
    let activeClasses: [ProfileClass]
    let performance: [SubjectPerformance]
    let recentTests: [ProfileTest]
}

struct ProfileClass: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let teacher: String
    let schedule: String
    let grade: Int
    let color: String
    
    var themeColor: Color {
        Color(hex: color)
    }
}

struct SubjectPerformance: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let score: Int
    let testsCompleted: Int
    let totalTests: Int
    let classAverage: Int
}

struct ProfileTest: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let `class`: String
    let date: String
    let score: Int
}


// MARK: - Test Result Model
struct TestResult: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let subject: String
    let className: String
    let teacher: String
    let teacherAvatar: String?
    let date: String
    let duration: String
    let score: Int
    let correct: Int
    let total: Int
    let classAverage: Int
}

struct TestResultDataSet: Codable {
    let recent: [TestResult]
    let best: [TestResult]
    let all: [TestResult]
}

// MARK: - Student Test Model (for the list page)
//struct StudentTest: Codable, Identifiable, Hashable {
//    let id: Int
//    let title: String
//    let subject: String
//    let className: String
//    let teacher: String
//    let teacherAvatar: String?
//    let classId: Int
//    let date: String
//    let time: String
//    let duration: String
//    let questions: Int
//    let status: String
//    var score: Int?
//}

//struct StudentTestDataSet: Codable {
//    let upcoming: [StudentTest]
//    let completed: [StudentTest]
//    let missed: [StudentTest]
//}

struct Test: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let subject: String
    let className: String
    let teacher: String
    let teacherAvatar: String?
    let classId: Int
    let date: String
    let time: String
    let duration: String
    let questions: Int
    let status: String
    var score: Int?
}

struct StudentTestDataSet: Codable {
    let upcoming: [Test]
    let completed: [Test]
    let missed: [Test]
}

// MARK: - Test Attempt Models (for the test-taking view)
struct TestDetails: Codable, Identifiable {
    let id: Int
    let title: String
    let subject: String
    let className: String
    let date: String
    let duration: Int // Duration in minutes
    let questions: [Question]
}

struct Question: Codable, Identifiable, Hashable {
    let id: String
    let question: String
    let options: [String]
    let correctAnswer: String
    let points: Int
    let image: String?
}


// an addition which was not here before

struct TestDataSet: Codable {
    let upcoming: [Test]
    let completed: [Test]
    let missed: [Test]
}


