//
//  AttemptTestViewModel.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 12/08/2025.
//

import Foundation
import Combine

// This ViewModel manages the state and logic for a single test-taking session.
@MainActor
class AttemptTestViewModel: ObservableObject {
    @Published var testDetails: TestDetails?
    @Published var currentQuestionIndex = 0
    @Published var answers: [String?]
    @Published var timeLeft: Int
    @Published var isSubmitted = false
    @Published var testResult: (score: Int, correct: Int, total: Int)?
    @Published var isSubmitAlertShowing = false

    private var timer: AnyCancellable?
    private let testId: Int

    init(testId: Int) {
        self.testId = testId
        
        // Load the specific test details from the JSON file.
        let details: TestDetails = load("test_details")
        self.testDetails = details
        
        // Initialize the answers array and timer.
        self.answers = Array(repeating: nil, count: details.questions.count)
        self.timeLeft = details.duration * 60 // Convert minutes to seconds
        
        startTimer()
    }

    // Starts the countdown timer for the test.
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeLeft > 0 {
                    self.timeLeft -= 1
                } else {
                    self.submitTest() // Auto-submit when time runs out.
                    self.stopTimer()
                }
            }
    }

    // Stops and invalidates the timer.
    func stopTimer() {
        timer?.cancel()
    }

    // Records the student's selected answer for the current question.
    func selectAnswer(_ option: String) {
        answers[currentQuestionIndex] = option
    }

    // Moves to the next question if available.
    func nextQuestion() {
        if currentQuestionIndex < (testDetails?.questions.count ?? 0) - 1 {
            currentQuestionIndex += 1
        }
    }

    // Moves to the previous question if available.
    func previousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }

    // Calculates the final score and marks the test as submitted.
    func submitTest() {
        stopTimer()
        guard let questions = testDetails?.questions else { return }
        
        var correctCount = 0
        for (index, question) in questions.enumerated() {
            if answers[index] == question.correctAnswer {
                correctCount += 1
            }
        }
        
        let score = Int((Double(correctCount) / Double(questions.count)) * 100)
        self.testResult = (score: score, correct: correctCount, total: questions.count)
        self.isSubmitted = true
    }
    
    // Computed property to count how many questions have been answered.
    var answeredCount: Int {
        answers.compactMap { $0 }.count
    }
}
