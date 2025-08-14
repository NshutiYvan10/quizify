//
//  AttemptTestView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 12/08/2025.
//

//working one but ugly

//import SwiftUI
//
//// The main view for a student to take a test.
//struct AttemptTestView: View {
//    @StateObject private var viewModel: AttemptTestViewModel
//    @Environment(\.dismiss) var dismiss
//
//    init(testId: Int) {
//        _viewModel = StateObject(wrappedValue: AttemptTestViewModel(testId: testId))
//    }
//
//    var body: some View {
//        VStack {
//            if viewModel.isSubmitted {
//                TestResultsSummaryView(viewModel: viewModel, onDismiss: { dismiss() })
//            } else if let test = viewModel.testDetails {
//                TestTakingView(test: test, viewModel: viewModel)
//            } else {
//                ProgressView("Loading Test...")
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.quizifyOffWhite)
//    }
//}
//
//// The UI shown while the student is actively taking the test.
//struct TestTakingView: View {
//    let test: TestDetails
//    @ObservedObject var viewModel: AttemptTestViewModel
//
//    var body: some View {
//        VStack(spacing: 20) {
//            TestInfoHeader(test: test, viewModel: viewModel)
//            
//            QuestionCardView(
//                question: test.questions[viewModel.currentQuestionIndex],
//                selectedAnswer: viewModel.answers[viewModel.currentQuestionIndex],
//                onSelectAnswer: { viewModel.selectAnswer($0) }
//            )
//            
//            QuestionNavigationView(
//                totalQuestions: test.questions.count,
//                currentQuestionIndex: $viewModel.currentQuestionIndex,
//                answers: viewModel.answers
//            )
//            
//            TestNavigationButtons(viewModel: viewModel)
//        }
//        .padding(30)
//        .alert("Submit Test?", isPresented: $viewModel.isSubmitAlertShowing) {
//            Button("Cancel", role: .cancel) {}
//            Button("Submit", role: .destructive) { viewModel.submitTest() }
//        } message: {
//            Text("You have answered \(viewModel.answeredCount) of \(test.questions.count) questions. Are you sure you want to submit?")
//        }
//    }
//}
//
//// Header view displaying test information and timer.
//struct TestInfoHeader: View {
//    let test: TestDetails
//    @ObservedObject var viewModel: AttemptTestViewModel
//    
//    private func formatTime(_ seconds: Int) -> String {
//        let mins = seconds / 60
//        let secs = seconds % 60
//        return "\(String(format: "%02d", mins)):\(String(format: "%02d", secs))"
//    }
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text(test.title).font(.largeTitle).fontWeight(.bold)
//                Spacer()
//                Text(formatTime(viewModel.timeLeft))
//                    .font(.title)
//                    .fontWeight(.semibold)
//                    .padding(8)
//                    .background(Color.quizifyLightGray.opacity(0.5))
//                    .cornerRadius(8)
//            }
//            
//            ProgressView(value: Double(viewModel.currentQuestionIndex + 1), total: Double(test.questions.count))
//            
//            HStack {
//                Text("Question \(viewModel.currentQuestionIndex + 1) of \(test.questions.count)")
//                Spacer()
//                Text("Answered: \(viewModel.answeredCount)/\(test.questions.count)")
//            }
//            .font(.subheadline)
//            .foregroundColor(.gray)
//        }
//    }
//}
//
//// A card that displays a single question and its options.
//struct QuestionCardView: View {
//    let question: Question
//    let selectedAnswer: String?
//    let onSelectAnswer: (String) -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            Text(question.question)
//                .font(.title2)
//                .fontWeight(.semibold)
//            
//            if let imageUrl = question.image, !imageUrl.isEmpty, let url = URL(string: imageUrl) {
//                AsyncImage(url: url) { $0.resizable().aspectRatio(contentMode: .fit) } placeholder: { ProgressView() }
//                    .frame(maxHeight: 250)
//                    .cornerRadius(12)
//            }
//            
//            ForEach(question.options, id: \.self) { option in
//                AnswerOptionRow(
//                    option: option,
//                    isSelected: option == selectedAnswer,
//                    onTap: { onSelectAnswer(option) }
//                )
//            }
//        }
//        .padding(30)
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(radius: 5)
//    }
//}
//
//// A row for a single answer option.
//struct AnswerOptionRow: View {
//    let option: String
//    let isSelected: Bool
//    let onTap: () -> Void
//
//    var body: some View {
//        Button(action: onTap) {
//            HStack {
//                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
//                    .foregroundColor(isSelected ? .quizifyPrimary : .gray)
//                Text(option)
//                Spacer()
//            }
//            .padding()
//            .background(isSelected ? Color.quizifyPrimary.opacity(0.1) : Color.clear)
//            .cornerRadius(10)
//            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isSelected ? Color.quizifyPrimary : .gray.opacity(0.5)))
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//// The navigation grid at the bottom to jump between questions.
//struct QuestionNavigationView: View {
//    let totalQuestions: Int
//    @Binding var currentQuestionIndex: Int
//    let answers: [String?]
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack {
//                ForEach(0..<totalQuestions, id: \.self) { index in
//                    Button(action: { currentQuestionIndex = index }) {
//                        Text("\(index + 1)")
//                            .frame(width: 40, height: 40)
//                            .background(buttonBackground(for: index))
//                            .foregroundColor(buttonForeground(for: index))
//                            .cornerRadius(8)
//                    }
//                }
//            }
//        }
//    }
//    
//    private func buttonBackground(for index: Int) -> Color {
//        if currentQuestionIndex == index {
//            return .quizifyPrimary
//        } else if answers[index] != nil {
//            return .quizifyAccentGreen.opacity(0.2)
//        } else {
//            return .gray.opacity(0.2)
//        }
//    }
//    
//    private func buttonForeground(for index: Int) -> Color {
//        if currentQuestionIndex == index {
//            return .white
//        } else if answers[index] != nil {
//            return .quizifyAccentGreen
//        } else {
//            return .primary
//        }
//    }
//}
//
//// The main navigation buttons (Previous, Next, Submit).
//struct TestNavigationButtons: View {
//    @ObservedObject var viewModel: AttemptTestViewModel
//    
//    var body: some View {
//        HStack {
//            Button(action: { viewModel.previousQuestion() }) {
//                Label("Previous", systemImage: "arrow.left")
//            }
//            .disabled(viewModel.currentQuestionIndex == 0)
//            
//            Spacer()
//            
//            if viewModel.currentQuestionIndex == (viewModel.testDetails?.questions.count ?? 0) - 1 {
//                Button("Submit Test") { viewModel.isSubmitAlertShowing = true }
//                    .buttonStyle(.borderedProminent)
//            } else {
//                Button(action: { viewModel.nextQuestion() }) {
//                    Label("Next", systemImage: "arrow.right")
//                }
//            }
//        }
//        .buttonStyle(.bordered)
//    }
//}
//
//// The view shown after the test is submitted.
//struct TestResultsSummaryView: View {
//    @ObservedObject var viewModel: AttemptTestViewModel
//    let onDismiss: () -> Void
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Test Completed!")
//                .font(.largeTitle).fontWeight(.bold)
//            
//            if let result = viewModel.testResult {
//                Text("Your Score: \(result.score)%")
//                    .font(.system(size: 60, weight: .bold))
//                    .foregroundColor(result.score >= 70 ? .quizifyAccentGreen : .quizifyRedError)
//                
//                Text("You got \(result.correct) out of \(result.total) questions correct.")
//                    .font(.title2)
//            }
//            
//            HStack {
//                Button("Review Answers") {}
//                Button("Back to Tests", action: onDismiss)
//                    .buttonStyle(.borderedProminent)
//            }
//            .buttonStyle(.bordered)
//        }
//    }
//}


import SwiftUI

// The main view for a student to take a test, presented as a full-screen cover.
struct AttemptTestView: View {
    @StateObject private var viewModel: AttemptTestViewModel
    let onFinish: () -> Void

    init(testId: Int, onFinish: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: AttemptTestViewModel(testId: testId))
        self.onFinish = onFinish
    }

    var body: some View {
        ZStack {
            // A subtle gradient background for a more polished look.
            LinearGradient(colors: [Color.quizifyOffWhite, .white], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            if viewModel.isSubmitted {
                TestResultsSummaryView(viewModel: viewModel, onDismiss: onFinish)
                    .transition(.scale.combined(with: .opacity))
            } else if let test = viewModel.testDetails {
                TestTakingView(test: test, viewModel: viewModel)
            } else {
                ProgressView("Loading Test...")
            }
        }
        .animation(.default, value: viewModel.isSubmitted)
    }
}

// The UI shown while the student is actively taking the test.
struct TestTakingView: View {
    let test: TestDetails
    @ObservedObject var viewModel: AttemptTestViewModel

    var body: some View {
        VStack(spacing: 25) {
            TestInfoHeader(test: test, viewModel: viewModel)
            
            QuestionCardView(
                question: test.questions[viewModel.currentQuestionIndex],
                selectedAnswer: viewModel.answers[viewModel.currentQuestionIndex],
                onSelectAnswer: { viewModel.selectAnswer($0) }
            )
            
            QuestionNavigationView(
                totalQuestions: test.questions.count,
                currentQuestionIndex: $viewModel.currentQuestionIndex,
                answers: viewModel.answers
            )
            
            TestNavigationButtons(viewModel: viewModel)
        }
        .padding(40)
        .alert("Submit Test?", isPresented: $viewModel.isSubmitAlertShowing) {
            Button("Cancel", role: .cancel) {}
            Button("Submit", role: .destructive) { viewModel.submitTest() }
        } message: {
            Text("You have answered \(viewModel.answeredCount) of \(test.questions.count) questions. Are you sure you want to submit?")
        }
    }
}

// Header view displaying test information and timer.
struct TestInfoHeader: View {
    let test: TestDetails
    @ObservedObject var viewModel: AttemptTestViewModel
    
    private func formatTime(_ seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return "\(String(format: "%02d", mins)):\(String(format: "%02d", secs))"
    }

    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(alignment: .leading) {
                    Text(test.title).font(.system(size: 32, weight: .bold))
                    Text(test.subject).font(.title2).foregroundColor(.gray)
                }
                Spacer()
                Text(formatTime(viewModel.timeLeft))
                    .font(.system(size: 28, weight: .semibold, design: .monospaced))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.quizifyPrimary)
                    .cornerRadius(12)
            }
            
            ProgressView(value: Double(viewModel.currentQuestionIndex + 1), total: Double(test.questions.count))
                .progressViewStyle(LinearProgressViewStyle(tint: .quizifyPrimary))
            
            HStack {
                Text("Question \(viewModel.currentQuestionIndex + 1) of \(test.questions.count)")
                Spacer()
                Text("Answered: \(viewModel.answeredCount)/\(test.questions.count)")
            }
            .font(.headline)
            .foregroundColor(.gray)
        }
    }
}

// A card that displays a single question and its options.
struct QuestionCardView: View {
    let question: Question
    let selectedAnswer: String?
    let onSelectAnswer: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question.question)
                .font(.system(size: 24, weight: .semibold))
            
            if let imageUrl = question.image, !imageUrl.isEmpty, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { $0.resizable().aspectRatio(contentMode: .fit) } placeholder: { ProgressView() }
                    .frame(maxHeight: 300)
                    .cornerRadius(12)
            }
            
            ForEach(question.options, id: \.self) { option in
                AnswerOptionRow(
                    option: option,
                    isSelected: option == selectedAnswer,
                    onTap: { onSelectAnswer(option) }
                )
            }
        }
        .padding(30)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
    }
}

// A row for a single answer option.
struct AnswerOptionRow: View {
    let option: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .font(.title2)
                    .foregroundColor(isSelected ? .quizifyPrimary : .gray)
                Text(option)
                    .font(.title3)
                Spacer()
            }
            .padding()
            .background(isSelected ? Color.quizifyPrimary.opacity(0.1) : Color.clear)
            .cornerRadius(12)
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(isSelected ? Color.quizifyPrimary : .gray.opacity(0.3), lineWidth: 2))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// The navigation grid at the bottom to jump between questions.
struct QuestionNavigationView: View {
    let totalQuestions: Int
    @Binding var currentQuestionIndex: Int
    let answers: [String?]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<totalQuestions, id: \.self) { index in
                    Button(action: { currentQuestionIndex = index }) {
                        Text("\(index + 1)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(width: 44, height: 44)
                            .background(buttonBackground(for: index))
                            .foregroundColor(buttonForeground(for: index))
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    private func buttonBackground(for index: Int) -> Color {
        if currentQuestionIndex == index {
            return .quizifyPrimary
        } else if answers[index] != nil {
            return .quizifyAccentGreen
        } else {
            return .gray.opacity(0.2)
        }
    }
    
    private func buttonForeground(for index: Int) -> Color {
        if currentQuestionIndex == index || answers[index] != nil {
            return .white
        } else {
            return .primary
        }
    }
}

// The main navigation buttons (Previous, Next, Submit).
struct TestNavigationButtons: View {
    @ObservedObject var viewModel: AttemptTestViewModel
    
    var body: some View {
        HStack {
            Button(action: { viewModel.previousQuestion() }) {
                Label("Previous", systemImage: "arrow.left.circle.fill")
                    .font(.headline)
                    .padding()
            }
            .buttonStyle(OutlineButtonStyle(color: .quizifyTextGray))
            .disabled(viewModel.currentQuestionIndex == 0)
            
            Spacer()
            
            if viewModel.currentQuestionIndex == (viewModel.testDetails?.questions.count ?? 0) - 1 {
                Button("Submit Test") { viewModel.isSubmitAlertShowing = true }
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.quizifyAccentGreen)
                    .cornerRadius(12)
            } else {
                Button(action: { viewModel.nextQuestion() }) {
                    Label("Next", systemImage: "arrow.right.circle.fill")
                        .font(.headline)
                        .padding()
                }
                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
            }
        }
    }
}

// The view shown after the test is submitted.
struct TestResultsSummaryView: View {
    @ObservedObject var viewModel: AttemptTestViewModel
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Test Completed!")
                .font(.system(size: 40, weight: .bold))
            
            if let result = viewModel.testResult {
                Text("Your Score: \(result.score)%")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(result.score >= 70 ? .quizifyAccentGreen : .quizifyRedError)
                
                Text("You got \(result.correct) out of \(result.total) questions correct.")
                    .font(.title)
                    .foregroundColor(.quizifyTextGray)
            }
            
            HStack(spacing: 20) {
                Button("Review Answers") {}
                    .font(.headline)
                    .padding()
                    .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))

                Button("Back to Tests", action: onDismiss)
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.quizifyPrimary)
                    .cornerRadius(12)
            }
            .padding(.top)
        }
    }
}

// The elegant confirmation dialog shown before starting a test.
struct StartTestConfirmationView: View {
    let test: Test
    let onStart: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "pencil.and.ruler.fill")
                .font(.system(size: 40))
                .foregroundColor(.quizifyPrimary)

            Text("Ready to Begin?")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("You are about to start the test:")
                .font(.title3)
                .foregroundColor(.gray)
            
            Text(test.title)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            VStack(spacing: 10) {
                Text("Duration: \(test.duration)")
                Text("Questions: \(test.questions)")
            }
            .font(.headline)
            .foregroundColor(.quizifyTextGray)
            
            HStack(spacing: 20) {
                Button("Cancel", action: onCancel)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .buttonStyle(OutlineButtonStyle(color: .quizifyTextGray))

                Button("Start Test", action: onStart)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.quizifyAccentGreen)
                    .cornerRadius(12)
            }
            .padding(.top)
        }
        .padding(40)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding(40)
    }
}
