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


// the final boss

//import SwiftUI
//
//// The main view for a student to take a test, presented as a full-screen cover.
//struct AttemptTestView: View {
//    @StateObject private var viewModel: AttemptTestViewModel
//    let onFinish: () -> Void
//
//    init(testId: Int, onFinish: @escaping () -> Void) {
//        _viewModel = StateObject(wrappedValue: AttemptTestViewModel(testId: testId))
//        self.onFinish = onFinish
//    }
//
//    var body: some View {
//        ZStack {
//            LinearGradient(colors: [Color.quizifyOffWhite, .white], startPoint: .top, endPoint: .bottom)
//                .edgesIgnoringSafeArea(.all)
//
//            if viewModel.isSubmitted {
//                TestResultsSummaryView(viewModel: viewModel, onDismiss: onFinish)
//                    .transition(.scale.combined(with: .opacity))
//            } else if let test = viewModel.testDetails {
//                TestTakingView(test: test, viewModel: viewModel)
//            } else {
//                ProgressView("Loading Test...")
//            }
//        }
//        .animation(.default, value: viewModel.isSubmitted)
//    }
//}
//
//// MARK: - Redesigned Confirmation Dialog
//struct StartTestConfirmationView: View {
//    let test: Test
//    let onStart: () -> Void
//    let onCancel: () -> Void
//
//    var body: some View {
//        VStack(spacing: 25) {
//            // MARK: Icon
//            Image(systemName: "graduationcap.fill")
//                .font(.system(size: 50))
//                .foregroundColor(.white)
//                .padding(20)
//                .background(
//                    Circle()
//                        .fill(Color.quizifyPrimary)
//                        .shadow(color: .quizifyPrimary.opacity(0.6), radius: 15, x: 0, y: 10) // Added glow
//                )
//
//            // MARK: Title and Subtitle
//            VStack(spacing: 8) {
//                Text("Ready to Begin?")
//                    .font(.system(size: 32, weight: .bold))
//                    .foregroundColor(.white) // Changed for better contrast
//                Text(test.title)
//                    .font(.title2)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white.opacity(0.8)) // Changed for better contrast
//                    .multilineTextAlignment(.center)
//            }
//
//            // MARK: Details Section
//            VStack(spacing: 15) {
//                ConfirmationDetailRow(icon: "book.closed.fill", label: "Subject", value: test.subject, color: .quizifyAccentBlue)
//                ConfirmationDetailRow(icon: "hourglass", label: "Duration", value: test.duration, color: .quizifyAccentYellow)
//                ConfirmationDetailRow(icon: "number.circle.fill", label: "Questions", value: "\(test.questions)", color: .quizifyAccentGreen)
//            }
//            .padding(25)
//            .background(.black.opacity(0.2)) // Darker, more glassy background
//            .cornerRadius(16)
//            .overlay(
//                RoundedRectangle(cornerRadius: 16)
//                    .stroke(Color.white.opacity(0.2), lineWidth: 1) // Subtle border
//            )
//
//            // MARK: Buttons
//            HStack(spacing: 20) {
//                Button(action: onCancel) {
//                    Text("Cancel")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                }
//                .buttonStyle(PlainButtonStyle())
//                .foregroundColor(.white.opacity(0.7)) // Changed for better contrast
//
//                Button(action: onStart) {
//                    Label("Start Test", systemImage: "arrow.right.circle.fill")
//                        .fontWeight(.bold)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                }
//                .buttonStyle(FilledButtonStyle(color: .quizifyAccentGreen))
//            }
//            .padding(.top, 10)
//        }
//        .padding(40)
//        // MARK: Glass Background Effect
//        .background(
//            // The .ultraThinMaterial has been removed and replaced with a custom glass effect.
//            // This ensures compatibility and provides a more stylized appearance.
//            ZStack {
//                // A translucent color provides the base of the glass effect.
//                Color.black.opacity(0.35)
//                
//                // Subtle gradient for a premium feel
//                LinearGradient(
//                    gradient: Gradient(colors: [
//                        Color.quizifyPrimary.opacity(0.4),
//                        Color.quizifyDarkBackground.opacity(0.6)
//                    ]),
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                )
//                
//                // Luminous border to define the shape
//                RoundedRectangle(cornerRadius: 25)
//                    .stroke(
//                        LinearGradient(
//                            gradient: Gradient(colors: [
//                                Color.white.opacity(0.4),
//                                Color.white.opacity(0.1)
//                            ]),
//                            startPoint: .top,
//                            endPoint: .bottom
//                        ),
//                        lineWidth: 1.5
//                    )
//            }
//        )
//        .cornerRadius(25)
//        .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 15) // Enhanced shadow
//        .padding(50)
//        .frame(maxWidth: 600)
//    }
//}
//
//
//// Helper for detail rows in the confirmation dialog
//fileprivate struct ConfirmationDetailRow: View {
//    let icon: String
//    let label: String
//    let value: String
//    let color: Color
//
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .font(.headline)
//                .foregroundColor(color)
//                .shadow(color: color.opacity(0.5), radius: 5) // Icon glow
//                .frame(width: 25)
//            Text(label)
//                .font(.headline)
//                .foregroundColor(.white.opacity(0.7))
//            Spacer()
//            Text(value)
//                .font(.headline)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//        }
//    }
//}
//
//// MARK: - Test Taking UI (Existing Code)
//struct TestTakingView: View {
//    let test: TestDetails
//    @ObservedObject var viewModel: AttemptTestViewModel
//
//    var body: some View {
//        VStack(spacing: 25) {
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
//        .padding(40)
//        .alert("Submit Test?", isPresented: $viewModel.isSubmitAlertShowing) {
//            Button("Cancel", role: .cancel) {}
//            Button("Submit", role: .destructive) { viewModel.submitTest() }
//        } message: {
//            Text("You have answered \(viewModel.answeredCount) of \(test.questions.count) questions. Are you sure you want to submit?")
//        }
//    }
//}
//
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
//        VStack(spacing: 15) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(test.title).font(.system(size: 32, weight: .bold))
//                    Text(test.subject).font(.title2).foregroundColor(.gray)
//                }
//                Spacer()
//                Text(formatTime(viewModel.timeLeft))
//                    .font(.system(size: 28, weight: .semibold, design: .monospaced))
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 10)
//                    .background(Color.quizifyPrimary)
//                    .cornerRadius(12)
//            }
//            
//            ProgressView(value: Double(viewModel.currentQuestionIndex + 1), total: Double(test.questions.count))
//                .progressViewStyle(LinearProgressViewStyle(tint: .quizifyPrimary))
//            
//            HStack {
//                Text("Question \(viewModel.currentQuestionIndex + 1) of \(test.questions.count)")
//                Spacer()
//                Text("Answered: \(viewModel.answeredCount)/\(test.questions.count)")
//            }
//            .font(.headline)
//            .foregroundColor(.gray)
//        }
//    }
//}
//
//struct QuestionCardView: View {
//    let question: Question
//    let selectedAnswer: String?
//    let onSelectAnswer: (String) -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            Text(question.question)
//                .font(.system(size: 24, weight: .semibold))
//            
//            if let imageUrl = question.image, !imageUrl.isEmpty, let url = URL(string: imageUrl) {
//                AsyncImage(url: url) { $0.resizable().aspectRatio(contentMode: .fit) } placeholder: { ProgressView() }
//                    .frame(maxHeight: 300)
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
//        .cornerRadius(20)
//        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
//    }
//}
//
//struct AnswerOptionRow: View {
//    let option: String
//    let isSelected: Bool
//    let onTap: () -> Void
//
//    var body: some View {
//        Button(action: onTap) {
//            HStack {
//                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
//                    .font(.title2)
//                    .foregroundColor(isSelected ? .quizifyPrimary : .gray)
//                Text(option)
//                    .font(.title3)
//                Spacer()
//            }
//            .padding()
//            .background(isSelected ? Color.quizifyPrimary.opacity(0.1) : Color.clear)
//            .cornerRadius(12)
//            .overlay(RoundedRectangle(cornerRadius: 12).stroke(isSelected ? Color.quizifyPrimary : .gray.opacity(0.3), lineWidth: 2))
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//struct QuestionNavigationView: View {
//    let totalQuestions: Int
//    @Binding var currentQuestionIndex: Int
//    let answers: [String?]
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 10) {
//                ForEach(0..<totalQuestions, id: \.self) { index in
//                    Button(action: { currentQuestionIndex = index }) {
//                        Text("\(index + 1)")
//                            .font(.headline)
//                            .fontWeight(.bold)
//                            .frame(width: 44, height: 44)
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
//            return .quizifyAccentGreen
//        } else {
//            return .gray.opacity(0.2)
//        }
//    }
//    
//    private func buttonForeground(for index: Int) -> Color {
//        if currentQuestionIndex == index || answers[index] != nil {
//            return .white
//        } else {
//            return .primary
//        }
//    }
//}
//
//struct TestNavigationButtons: View {
//    @ObservedObject var viewModel: AttemptTestViewModel
//    
//    var body: some View {
//        HStack {
//            Button(action: { viewModel.previousQuestion() }) {
//                Label("Previous", systemImage: "arrow.left.circle.fill")
//                    .font(.headline)
//                    .padding()
//            }
//            .buttonStyle(OutlineButtonStyle(color: .quizifyTextGray))
//            .disabled(viewModel.currentQuestionIndex == 0)
//            
//            Spacer()
//            
//            if viewModel.currentQuestionIndex == (viewModel.testDetails?.questions.count ?? 0) - 1 {
//                Button("Submit Test") { viewModel.isSubmitAlertShowing = true }
//                    .font(.headline)
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.quizifyAccentGreen)
//                    .cornerRadius(12)
//            } else {
//                Button(action: { viewModel.nextQuestion() }) {
//                    Label("Next", systemImage: "arrow.right.circle.fill")
//                        .font(.headline)
//                        .padding()
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//            }
//        }
//    }
//}
//
//struct TestResultsSummaryView: View {
//    @ObservedObject var viewModel: AttemptTestViewModel
//    let onDismiss: () -> Void
//    
//    var body: some View {
//        VStack(spacing: 25) {
//            Text("Test Completed!")
//                .font(.system(size: 40, weight: .bold))
//            
//            if let result = viewModel.testResult {
//                Text("Your Score: \(result.score)%")
//                    .font(.system(size: 72, weight: .bold))
//                    .foregroundColor(result.score >= 70 ? .quizifyAccentGreen : .quizifyRedError)
//                
//                Text("You got \(result.correct) out of \(result.total) questions correct.")
//                    .font(.title)
//                    .foregroundColor(.quizifyTextGray)
//            }
//            
//            HStack(spacing: 20) {
//                Button("Review Answers") {}
//                    .font(.headline)
//                    .padding()
//                    .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//
//                Button("Back to Tests", action: onDismiss)
//                    .font(.headline)
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.quizifyPrimary)
//                    .cornerRadius(12)
//            }
//            .padding(.top)
//        }
//    }
//}


// changes with the start test button reduced padding

//import SwiftUI
//
//// The main view for a student to take a test, presented as a full-screen cover.
//struct AttemptTestView: View {
//    @StateObject private var viewModel: AttemptTestViewModel
//    let onFinish: () -> Void
//
//    init(testId: Int, onFinish: @escaping () -> Void) {
//        _viewModel = StateObject(wrappedValue: AttemptTestViewModel(testId: testId))
//        self.onFinish = onFinish
//    }
//
//    var body: some View {
//        ZStack {
//            LinearGradient(colors: [Color.quizifyOffWhite, .white], startPoint: .top, endPoint: .bottom)
//                .edgesIgnoringSafeArea(.all)
//
//            if viewModel.isSubmitted {
//                TestResultsSummaryView(viewModel: viewModel, onDismiss: onFinish)
//                    .transition(.scale.combined(with: .opacity))
//            } else if let test = viewModel.testDetails {
//                TestTakingView(test: test, viewModel: viewModel)
//            } else {
//                ProgressView("Loading Test...")
//            }
//        }
//        .animation(.default, value: viewModel.isSubmitted)
//    }
//}
//
//// MARK: - Redesigned Confirmation Dialog
//struct StartTestConfirmationView: View {
//    let test: Test
//    let onStart: () -> Void
//    let onCancel: () -> Void
//
//    var body: some View {
//        VStack(spacing: 25) {
//            // MARK: Icon
//            Image(systemName: "graduationcap.fill")
//                .font(.system(size: 50))
//                .foregroundColor(.white)
//                .padding(20)
//                .background(
//                    Circle()
//                        .fill(Color.quizifyPrimary)
//                        .shadow(color: .quizifyPrimary.opacity(0.6), radius: 15, x: 0, y: 10) // Added glow
//                )
//
//            // MARK: Title and Subtitle
//            VStack(spacing: 8) {
//                Text("Ready to Begin?")
//                    .font(.system(size: 32, weight: .bold))
//                    .foregroundColor(.white)
//                Text(test.title)
//                    .font(.title2)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white.opacity(0.8))
//                    .multilineTextAlignment(.center)
//            }
//
//            // MARK: Details Section
//            VStack(spacing: 15) {
//                ConfirmationDetailRow(icon: "book.closed.fill", label: "Subject", value: test.subject, color: .quizifyAccentBlue)
//                ConfirmationDetailRow(icon: "hourglass", label: "Duration", value: test.duration, color: .quizifyAccentYellow)
//                ConfirmationDetailRow(icon: "number.circle.fill", label: "Questions", value: "\(test.questions)", color: .quizifyAccentGreen)
//            }
//            .padding(25)
//            .background(.black.opacity(0.2))
//            .cornerRadius(16)
//            .overlay(
//                RoundedRectangle(cornerRadius: 16)
//                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
//            )
//
//            // MARK: Buttons
//            HStack(spacing: 20) {
//                Button(action: onCancel) {
//                    Text("Cancel")
//                        .fontWeight(.semibold)
//                        .padding()
//                }
//                .buttonStyle(PlainButtonStyle())
//                .foregroundColor(.white.opacity(0.7))
//
//                Button(action: onStart) {
//                    Label("Start Test", systemImage: "arrow.right.circle.fill")
//                        .fontWeight(.bold)
//                        // Reduced horizontal padding for a more balanced look
//                        .padding(.vertical)
//                        .padding(.horizontal, 30)
//                }
//                .buttonStyle(FilledButtonStyle(color: .quizifyAccentGreen))
//            }
//            .padding(.top, 10)
//        }
//        .padding(40)
//        // MARK: Glass Background Effect
//        .background(
//            ZStack {
//                // Increased opacity for better visibility while maintaining the glass effect.
//                Color.black.opacity(0.45)
//                
//                // Adjusted gradient for a richer glass tint.
//                LinearGradient(
//                    gradient: Gradient(colors: [
//                        Color.quizifyPrimary.opacity(0.5),
//                        Color.quizifyDarkBackground.opacity(0.7)
//                    ]),
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                )
//                
//                // Luminous border to define the shape
//                RoundedRectangle(cornerRadius: 25)
//                    .stroke(
//                        LinearGradient(
//                            gradient: Gradient(colors: [
//                                Color.white.opacity(0.4),
//                                Color.white.opacity(0.1)
//                            ]),
//                            startPoint: .top,
//                            endPoint: .bottom
//                        ),
//                        lineWidth: 1.5
//                    )
//            }
//        )
//        .cornerRadius(25)
//        .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 15)
//        .padding(50)
//        .frame(maxWidth: 600)
//    }
//}
//
//
//// Helper for detail rows in the confirmation dialog
//fileprivate struct ConfirmationDetailRow: View {
//    let icon: String
//    let label: String
//    let value: String
//    let color: Color
//
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .font(.headline)
//                .foregroundColor(color)
//                .shadow(color: color.opacity(0.5), radius: 5) // Icon glow
//                .frame(width: 25)
//            Text(label)
//                .font(.headline)
//                .foregroundColor(.white.opacity(0.7))
//            Spacer()
//            Text(value)
//                .font(.headline)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//        }
//    }
//}
//
//// MARK: - Test Taking UI (Existing Code)
//struct TestTakingView: View {
//    let test: TestDetails
//    @ObservedObject var viewModel: AttemptTestViewModel
//
//    var body: some View {
//        VStack(spacing: 25) {
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
//        .padding(40)
//        .alert("Submit Test?", isPresented: $viewModel.isSubmitAlertShowing) {
//            Button("Cancel", role: .cancel) {}
//            Button("Submit", role: .destructive) { viewModel.submitTest() }
//        } message: {
//            Text("You have answered \(viewModel.answeredCount) of \(test.questions.count) questions. Are you sure you want to submit?")
//        }
//    }
//}
//
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
//        VStack(spacing: 15) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(test.title).font(.system(size: 32, weight: .bold))
//                    Text(test.subject).font(.title2).foregroundColor(.gray)
//                }
//                Spacer()
//                Text(formatTime(viewModel.timeLeft))
//                    .font(.system(size: 28, weight: .semibold, design: .monospaced))
//                    .foregroundColor(.white)
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 10)
//                    .background(Color.quizifyPrimary)
//                    .cornerRadius(12)
//            }
//            
//            ProgressView(value: Double(viewModel.currentQuestionIndex + 1), total: Double(test.questions.count))
//                .progressViewStyle(LinearProgressViewStyle(tint: .quizifyPrimary))
//            
//            HStack {
//                Text("Question \(viewModel.currentQuestionIndex + 1) of \(test.questions.count)")
//                Spacer()
//                Text("Answered: \(viewModel.answeredCount)/\(test.questions.count)")
//            }
//            .font(.headline)
//            .foregroundColor(.gray)
//        }
//    }
//}
//
//struct QuestionCardView: View {
//    let question: Question
//    let selectedAnswer: String?
//    let onSelectAnswer: (String) -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            Text(question.question)
//                .font(.system(size: 24, weight: .semibold))
//            
//            if let imageUrl = question.image, !imageUrl.isEmpty, let url = URL(string: imageUrl) {
//                AsyncImage(url: url) { $0.resizable().aspectRatio(contentMode: .fit) } placeholder: { ProgressView() }
//                    .frame(maxHeight: 300)
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
//        .cornerRadius(20)
//        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
//    }
//}
//
//struct AnswerOptionRow: View {
//    let option: String
//    let isSelected: Bool
//    let onTap: () -> Void
//
//    var body: some View {
//        Button(action: onTap) {
//            HStack {
//                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
//                    .font(.title2)
//                    .foregroundColor(isSelected ? .quizifyPrimary : .gray)
//                Text(option)
//                    .font(.title3)
//                Spacer()
//            }
//            .padding()
//            .background(isSelected ? Color.quizifyPrimary.opacity(0.1) : Color.clear)
//            .cornerRadius(12)
//            .overlay(RoundedRectangle(cornerRadius: 12).stroke(isSelected ? Color.quizifyPrimary : .gray.opacity(0.3), lineWidth: 2))
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//struct QuestionNavigationView: View {
//    let totalQuestions: Int
//    @Binding var currentQuestionIndex: Int
//    let answers: [String?]
//
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 10) {
//                ForEach(0..<totalQuestions, id: \.self) { index in
//                    Button(action: { currentQuestionIndex = index }) {
//                        Text("\(index + 1)")
//                            .font(.headline)
//                            .fontWeight(.bold)
//                            .frame(width: 44, height: 44)
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
//            return .quizifyAccentGreen
//        } else {
//            return .gray.opacity(0.2)
//        }
//    }
//    
//    private func buttonForeground(for index: Int) -> Color {
//        if currentQuestionIndex == index || answers[index] != nil {
//            return .white
//        } else {
//            return .primary
//        }
//    }
//}
//
//struct TestNavigationButtons: View {
//    @ObservedObject var viewModel: AttemptTestViewModel
//    
//    var body: some View {
//        HStack {
//            Button(action: { viewModel.previousQuestion() }) {
//                Label("Previous", systemImage: "arrow.left.circle.fill")
//                    .font(.headline)
//                    .padding()
//            }
//            .buttonStyle(OutlineButtonStyle(color: .quizifyTextGray))
//            .disabled(viewModel.currentQuestionIndex == 0)
//            
//            Spacer()
//            
//            if viewModel.currentQuestionIndex == (viewModel.testDetails?.questions.count ?? 0) - 1 {
//                Button("Submit Test") { viewModel.isSubmitAlertShowing = true }
//                    .font(.headline)
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.quizifyAccentGreen)
//                    .cornerRadius(12)
//            } else {
//                Button(action: { viewModel.nextQuestion() }) {
//                    Label("Next", systemImage: "arrow.right.circle.fill")
//                        .font(.headline)
//                        .padding()
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//            }
//        }
//    }
//}
//
//struct TestResultsSummaryView: View {
//    @ObservedObject var viewModel: AttemptTestViewModel
//    let onDismiss: () -> Void
//    
//    var body: some View {
//        VStack(spacing: 25) {
//            Text("Test Completed!")
//                .font(.system(size: 40, weight: .bold))
//            
//            if let result = viewModel.testResult {
//                Text("Your Score: \(result.score)%")
//                    .font(.system(size: 72, weight: .bold))
//                    .foregroundColor(result.score >= 70 ? .quizifyAccentGreen : .quizifyRedError)
//                
//                Text("You got \(result.correct) out of \(result.total) questions correct.")
//                    .font(.title)
//                    .foregroundColor(.quizifyTextGray)
//            }
//            
//            HStack(spacing: 20) {
//                Button("Review Answers") {}
//                    .font(.headline)
//                    .padding()
//                    .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//
//                Button("Back to Tests", action: onDismiss)
//                    .font(.headline)
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.quizifyPrimary)
//                    .cornerRadius(12)
//            }
//            .padding(.top)
//        }
//    }
//}




// a new but still messy structure of the AttemptTest page

//import SwiftUI
//
//// The main view for a student to take a test, presented as a full-screen cover.
//struct AttemptTestView: View {
//    @StateObject private var viewModel: AttemptTestViewModel
//    @State private var showExitConfirmation = false
//    let onFinish: () -> Void
//
//    init(testId: Int, onFinish: @escaping () -> Void) {
//        _viewModel = StateObject(wrappedValue: AttemptTestViewModel(testId: testId))
//        self.onFinish = onFinish
//    }
//
//    var body: some View {
//        ZStack {
//            // A subtle gradient background for a more polished look.
//            LinearGradient(colors: [Color(hex: "#F0F2F5"), .white], startPoint: .top, endPoint: .bottom)
//                .edgesIgnoringSafeArea(.all)
//
//            if viewModel.isSubmitted {
//                TestResultsSummaryView(viewModel: viewModel, onDismiss: onFinish)
//                    .transition(.scale.combined(with: .opacity))
//            } else if let test = viewModel.testDetails {
//                TestTakingView(
//                    test: test,
//                    viewModel: viewModel,
//                    onExit: { showExitConfirmation = true }
//                )
//            } else {
//                ProgressView("Loading Test...")
//            }
//            
//            // MARK: - Exit Confirmation Dialog
//            if showExitConfirmation {
//                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
//                ExitTestConfirmationView(
//                    onConfirmExit: {
//                        // In a real app, you'd mark the test as missed here.
//                        onFinish()
//                    },
//                    onCancel: { showExitConfirmation = false }
//                )
//                .transition(.move(edge: .bottom).combined(with: .opacity))
//            }
//        }
//        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: showExitConfirmation)
//        .animation(.default, value: viewModel.isSubmitted)
//    }
//}
//
//// MARK: - Main Test-Taking Layout
//struct TestTakingView: View {
//    let test: TestDetails
//    @ObservedObject var viewModel: AttemptTestViewModel
//    let onExit: () -> Void
//
//    var body: some View {
//        VStack(spacing: 0) {
//            // MARK: - Header
//            TestInfoHeader(test: test, onExit: onExit)
//
//            // MARK: - Main Content Area
//            HStack(alignment: .top, spacing: 30) {
//                // MARK: Left Column (Question & Navigation)
//                VStack(spacing: 25) {
//                    QuestionProgressHeader(
//                        current: viewModel.currentQuestionIndex + 1,
//                        total: viewModel.totalQuestions
//                    )
//                    
//                    QuestionCardView(
//                        question: test.questions[viewModel.currentQuestionIndex],
//                        selectedAnswer: viewModel.answers[viewModel.currentQuestionIndex],
//                        onSelectAnswer: { viewModel.selectAnswer($0) }
//                    )
//                    
//                    QuestionNavigationView(
//                        totalQuestions: test.questions.count,
//                        currentQuestionIndex: $viewModel.currentQuestionIndex,
//                        answers: viewModel.answers
//                    )
//                    
//                    TestNavigationButtons(viewModel: viewModel)
//                }
//                .frame(maxWidth: .infinity, alignment: .top)
//
//                // MARK: Right Column (Timer & Progress Summary)
//                VStack(spacing: 30) {
//                    TimerCardView(timeLeft: viewModel.timeLeft, totalTime: test.duration * 60)
//                    QuestionStatusSummaryCard(viewModel: viewModel)
//                }
//                .frame(width: 380, alignment: .top)
//            }
//            .padding(30)
//            
//            // MARK: - Scratchpad Section
//            ScratchpadView()
//                .padding(.horizontal, 30)
//                .padding(.bottom, 30)
//        }
//    }
//}
//
//// Extension to add computed properties to the ViewModel.
//extension AttemptTestViewModel {
//    var totalQuestions: Int {
//        testDetails?.questions.count ?? 0
//    }
//    
//    var unansweredCount: Int {
//        totalQuestions - answeredCount
//    }
//}
//
//
//// MARK: - Redesigned Subviews
//struct TestInfoHeader: View {
//    let test: TestDetails
//    let onExit: () -> Void
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(test.title).font(.system(size: 28, weight: .bold))
//                Text(test.subject).font(.title2).foregroundColor(.gray)
//            }
//            Spacer()
//            Button(action: onExit) {
//                Label("Exit Test", systemImage: "xmark.circle.fill")
//                    .font(.headline)
//                    .padding()
//            }
//            .buttonStyle(OutlineButtonStyle(color: .quizifyRedError))
//        }
//        .padding(.horizontal, 30)
//        .padding(.vertical, 20)
//        .background(Color.white.shadow(.drop(color: .black.opacity(0.05), radius: 5, y: 5)))
//    }
//}
//
//struct QuestionProgressHeader: View {
//    let current: Int
//    let total: Int
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text("Question \(current) of \(total)")
//                .font(.headline)
//                .foregroundColor(.quizifyTextGray)
//            
//            ProgressView(value: Double(current), total: Double(total))
//                .progressViewStyle(LinearProgressViewStyle(tint: .quizifyPrimary))
//                .scaleEffect(x: 1, y: 1.5, anchor: .center)
//                .cornerRadius(4)
//        }
//    }
//}
//
//struct TimerCardView: View {
//    let timeLeft: Int
//    let totalTime: Int
//    
//    private func formatTime(_ seconds: Int) -> String {
//        let mins = seconds / 60
//        let secs = seconds % 60
//        return "\(String(format: "%02d", mins)):\(String(format: "%02d", secs))"
//    }
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Label("Time Remaining", systemImage: "alarm.fill")
//                .font(.title3.weight(.semibold))
//                .foregroundColor(.quizifyTextGray)
//            
//            ZStack {
//                Circle()
//                    .stroke(lineWidth: 15.0)
//                    .opacity(0.1)
//                    .foregroundColor(.quizifyPrimary)
//                
//                Circle()
//                    .trim(from: 0.0, to: CGFloat(timeLeft) / CGFloat(totalTime))
//                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
//                    .foregroundColor(.quizifyPrimary)
//                    .rotationEffect(Angle(degrees: 270.0))
//                    .animation(.linear(duration: 1.0), value: timeLeft)
//
//                Text(formatTime(timeLeft))
//                    .font(.system(size: 48, weight: .bold, design: .monospaced))
//                    .foregroundColor(.quizifyPrimary)
//            }
//            .frame(width: 200, height: 200)
//        }
//        .frame(maxWidth: .infinity)
//        .padding(30)
//        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
//    }
//}
//
//struct QuestionStatusSummaryCard: View {
//    @ObservedObject var viewModel: AttemptTestViewModel
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            Text("Answer Summary")
//                .font(.title2)
//                .fontWeight(.bold)
//            
//            Divider()
//            
//            ScrollView {
//                VStack(spacing: 12) {
//                    ForEach(0..<viewModel.totalQuestions, id: \.self) { index in
//                        HStack {
//                            Text("Question \(index + 1)")
//                                .fontWeight(.medium)
//                            Spacer()
//                            if viewModel.answers[index] != nil {
//                                Label("Answered", systemImage: "checkmark.circle.fill")
//                                    .foregroundColor(.quizifyAccentGreen)
//                            } else if index < viewModel.currentQuestionIndex {
//                                Label("Not Answered", systemImage: "xmark.circle.fill")
//                                    .foregroundColor(.quizifyRedError)
//                            } else {
//                                Label("Not Yet Reached", systemImage: "circle.dotted")
//                                    .foregroundColor(.quizifyTextGray)
//                            }
//                        }
//                        .font(.headline)
//                    }
//                }
//            }
//        }
//        .padding(30)
//        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
//    }
//}
//
//struct QuestionCardView: View {
//    let question: Question
//    let selectedAnswer: String?
//    let onSelectAnswer: (String) -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 25) {
//            Text(question.question)
//                .font(.system(size: 24, weight: .semibold))
//            
//            if let imageUrl = question.image, !imageUrl.isEmpty, let url = URL(string: imageUrl) {
//                AsyncImage(url: url) { $0.resizable().aspectRatio(contentMode: .fit) } placeholder: { ProgressView() }
//                    .frame(maxHeight: 300)
//                    .cornerRadius(16)
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
//        .cornerRadius(20)
//        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
//        .frame(maxHeight: .infinity)
//    }
//}
//
//struct AnswerOptionRow: View {
//    let option: String
//    let isSelected: Bool
//    let onTap: () -> Void
//
//    var body: some View {
//        Button(action: onTap) {
//            HStack {
//                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
//                    .font(.title2)
//                    .foregroundColor(isSelected ? .quizifyPrimary : .gray)
//                Text(option)
//                    .font(.title3)
//                Spacer()
//            }
//            .padding()
//            .background(isSelected ? Color.quizifyPrimary.opacity(0.1) : Color.clear)
//            .cornerRadius(12)
//            .overlay(RoundedRectangle(cornerRadius: 12).stroke(isSelected ? Color.quizifyPrimary : .gray.opacity(0.3), lineWidth: 2))
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//struct QuestionNavigationView: View {
//    let totalQuestions: Int
//    @Binding var currentQuestionIndex: Int
//    let answers: [String?]
//
//    var body: some View {
//        ScrollViewReader { proxy in
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 10) {
//                    ForEach(0..<totalQuestions, id: \.self) { index in
//                        Button(action: {
//                            withAnimation {
//                                currentQuestionIndex = index
//                            }
//                        }) {
//                            Text("\(index + 1)")
//                                .font(.headline)
//                                .fontWeight(.bold)
//                                .frame(width: 44, height: 44)
//                                .background(buttonBackground(for: index))
//                                .foregroundColor(buttonForeground(for: index))
//                                .cornerRadius(8)
//                        }
//                        .id(index)
//                    }
//                }
//            }
//            .onChange(of: currentQuestionIndex) {
//                withAnimation {
//                    proxy.scrollTo(currentQuestionIndex, anchor: .center)
//                }
//            }
//        }
//    }
//    
//    private func buttonBackground(for index: Int) -> Color {
//        if currentQuestionIndex == index {
//            return .quizifyPrimary
//        } else if answers[index] != nil {
//            return .quizifyAccentGreen
//        } else {
//            return .gray.opacity(0.2)
//        }
//    }
//    
//    private func buttonForeground(for index: Int) -> Color {
//        if currentQuestionIndex == index || answers[index] != nil {
//            return .white
//        } else {
//            return .primary
//        }
//    }
//}
//
//struct TestNavigationButtons: View {
//    @ObservedObject var viewModel: AttemptTestViewModel
//    
//    var body: some View {
//        HStack {
//            Button(action: { viewModel.previousQuestion() }) {
//                Label("Previous", systemImage: "arrow.left.circle.fill")
//                    .font(.headline)
//                    .padding()
//            }
//            .buttonStyle(OutlineButtonStyle(color: .quizifyTextGray))
//            .disabled(viewModel.currentQuestionIndex == 0)
//            
//            Spacer()
//            
//            if viewModel.currentQuestionIndex == viewModel.totalQuestions - 1 {
//                Button("Submit Test") { viewModel.isSubmitAlertShowing = true }
//                    .font(.headline)
//                    .padding()
//                    .buttonStyle(FilledButtonStyle(color: .quizifyAccentGreen))
//            } else {
//                Button(action: { viewModel.nextQuestion() }) {
//                    Label("Next", systemImage: "arrow.right.circle.fill")
//                        .font(.headline)
//                        .padding()
//                }
//                .buttonStyle(FilledButtonStyle(color: .quizifyPrimary))
//            }
//        }
//    }
//}
//
//struct ScratchpadView: View {
//    @State private var notes = ""
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Label("Scratchpad", systemImage: "pencil.and.scribble")
//                .font(.headline)
//                .foregroundColor(.quizifyTextGray)
//            
//            TextEditor(text: $notes)
//                .padding(10)
//                .background(Color.white)
//                .cornerRadius(12)
//                .shadow(color: .black.opacity(0.05), radius: 5)
//                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2)))
//        }
//        .frame(height: 200)
//    }
//}
//
//// MARK: - Confirmation and Result Views
//struct ExitTestConfirmationView: View {
//    let onConfirmExit: () -> Void
//    let onCancel: () -> Void
//
//    var body: some View {
//        VStack(spacing: 25) {
//            Image(systemName: "exclamationmark.triangle.fill")
//                .font(.system(size: 50))
//                .foregroundColor(.orange)
//                .padding(20)
//                .background(Circle().fill(Color.orange.opacity(0.1)))
//
//            VStack(spacing: 8) {
//                Text("Leave Test?")
//                    .font(.system(size: 32, weight: .bold))
//                    .foregroundColor(.white)
//                Text("If you leave now, the test will be marked as missed. This action cannot be undone.")
//                    .font(.title3)
//                    .foregroundColor(.white.opacity(0.8))
//                    .multilineTextAlignment(.center)
//            }
//
//            HStack(spacing: 20) {
//                Button(action: onCancel) {
//                    Text("Stay")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                }
//                .buttonStyle(OutlineButtonStyle(color: .white))
//
//                Button(action: onConfirmExit) {
//                    Label("Leave Test", systemImage: "door.left.hand.open")
//                        .fontWeight(.bold)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                }
//                .buttonStyle(FilledButtonStyle(color: .quizifyRedError))
//            }
//            .padding(.top, 10)
//        }
//        .padding(40)
//        .background(
//            ZStack {
//                Color.black.opacity(0.45)
//                LinearGradient(
//                    gradient: Gradient(colors: [
//                        Color.quizifyRedError.opacity(0.5),
//                        Color.quizifyDarkBackground.opacity(0.7)
//                    ]),
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                )
//                RoundedRectangle(cornerRadius: 25)
//                    .stroke(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.4), Color.white.opacity(0.1)]), startPoint: .top, endPoint: .bottom), lineWidth: 1.5)
//            }
//        )
//        .cornerRadius(25)
//        .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 15)
//        .padding(50)
//        .frame(maxWidth: 600)
//    }
//}
//
//struct TestResultsSummaryView: View {
//    @ObservedObject var viewModel: AttemptTestViewModel
//    let onDismiss: () -> Void
//    
//    var body: some View {
//        VStack(spacing: 25) {
//            Text("Test Completed!")
//                .font(.system(size: 40, weight: .bold))
//            
//            if let result = viewModel.testResult {
//                Text("Your Score: \(result.score)%")
//                    .font(.system(size: 72, weight: .bold))
//                    .foregroundColor(result.score >= 70 ? .quizifyAccentGreen : .quizifyRedError)
//                
//                Text("You got \(result.correct) out of \(result.total) questions correct.")
//                    .font(.title)
//                    .foregroundColor(.quizifyTextGray)
//            }
//            
//            HStack(spacing: 20) {
//                Button("Review Answers") {}
//                    .font(.headline)
//                    .padding()
//                    .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//
//                Button("Back to Tests", action: onDismiss)
//                    .font(.headline)
//                    .padding()
//                    .buttonStyle(FilledButtonStyle(color: .quizifyPrimary))
//            }
//            .padding(.top)
//        }
//    }
//}






import SwiftUI

// The main view for a student to take a test, presented as a full-screen cover.
struct AttemptTestView: View {
    @StateObject private var viewModel: AttemptTestViewModel
    @State private var showExitConfirmation = false
    let onFinish: () -> Void

    init(testId: Int, onFinish: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: AttemptTestViewModel(testId: testId))
        self.onFinish = onFinish
    }

    var body: some View {
        ZStack {
            // A subtle gradient background for a more polished look.
            LinearGradient(colors: [Color(hex: "#F0F2F5"), .white], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            if viewModel.isSubmitted {
                TestResultsSummaryView(viewModel: viewModel, onDismiss: onFinish)
                    .transition(.scale.combined(with: .opacity))
            } else if let test = viewModel.testDetails {
                TestTakingView(
                    test: test,
                    viewModel: viewModel,
                    onExit: { showExitConfirmation = true }
                )
            } else {
                ProgressView("Loading Test...")
            }
            
            // MARK: - Exit Confirmation Dialog
            if showExitConfirmation {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                ExitTestConfirmationView(
                    onConfirmExit: {
                        // In a real app, you'd mark the test as missed here.
                        onFinish()
                    },
                    onCancel: { showExitConfirmation = false }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: showExitConfirmation)
        .animation(.default, value: viewModel.isSubmitted)
    }
}

// MARK: - Main Test-Taking Layout
struct TestTakingView: View {
    let test: TestDetails
    @ObservedObject var viewModel: AttemptTestViewModel
    let onExit: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Header
            TestInfoHeader(test: test, onExit: onExit)

            // MARK: - Main Content Area
            HStack(alignment: .top, spacing: 30) {
                // MARK: Left Column (Question & Navigation)
                VStack(spacing: 20) { // Reduced vertical spacing
                    QuestionProgressHeader(
                        current: viewModel.currentQuestionIndex + 1,
                        total: viewModel.totalQuestions
                    )
                    
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
                .frame(maxWidth: .infinity, alignment: .top)

                // MARK: Right Column (Timer & Progress Summary)
                VStack(spacing: 30) {
                    TimerCardView(timeLeft: viewModel.timeLeft, totalTime: test.duration * 60)
                    QuestionStatusSummaryCard(viewModel: viewModel)
                }
                .frame(width: 380, alignment: .top)
            }
            .padding(30)
            
            // MARK: - Scratchpad Section
            ScratchpadView()
                .padding(.horizontal, 30)
                .padding(.bottom, 30)
        }
    }
}

// Extension to add computed properties to the ViewModel.
extension AttemptTestViewModel {
    var totalQuestions: Int {
        testDetails?.questions.count ?? 0
    }
    
    var unansweredCount: Int {
        totalQuestions - answeredCount
    }
}


// MARK: - Redesigned Subviews
struct TestInfoHeader: View {
    let test: TestDetails
    let onExit: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(test.title).font(.system(size: 28, weight: .bold))
                Text(test.subject).font(.title2).foregroundColor(.gray)
            }
            Spacer()
            Button(action: onExit) {
                Label("Exit Test", systemImage: "xmark.circle.fill")
                    .font(.headline)
                    .padding()
            }
            .buttonStyle(OutlineButtonStyle(color: .quizifyRedError))
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        .background(Color.white.shadow(.drop(color: .black.opacity(0.05), radius: 5, y: 5)))
    }
}

struct QuestionProgressHeader: View {
    let current: Int
    let total: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Question \(current) of \(total)")
                .font(.headline)
                .foregroundColor(.quizifyTextGray)
            
            ProgressView(value: Double(current), total: Double(total))
                .progressViewStyle(LinearProgressViewStyle(tint: .quizifyPrimary))
                .scaleEffect(x: 1, y: 1.5, anchor: .center)
                .cornerRadius(4)
        }
    }
}

struct TimerCardView: View {
    let timeLeft: Int
    let totalTime: Int
    
    private func formatTime(_ seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return "\(String(format: "%02d", mins)):\(String(format: "%02d", secs))"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Label("Time Remaining", systemImage: "alarm.fill")
                .font(.title3.weight(.semibold))
                .foregroundColor(.quizifyTextGray)
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 15.0)
                    .opacity(0.1)
                    .foregroundColor(.quizifyPrimary)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(timeLeft) / CGFloat(totalTime))
                    .stroke(style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.quizifyPrimary)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear(duration: 1.0), value: timeLeft)

                Text(formatTime(timeLeft))
                    .font(.system(size: 48, weight: .bold, design: .monospaced))
                    .foregroundColor(.quizifyPrimary)
            }
            .frame(width: 200, height: 200)
        }
        .frame(maxWidth: .infinity)
        .padding(30)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
    }
}

struct QuestionStatusSummaryCard: View {
    @ObservedObject var viewModel: AttemptTestViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Answer Summary")
                .font(.title2)
                .fontWeight(.bold)
            
            Divider()
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(0..<viewModel.totalQuestions, id: \.self) { index in
                        HStack {
                            Text("Question \(index + 1)")
                                .fontWeight(.medium)
                            Spacer()
                            if viewModel.answers[index] != nil {
                                Label("Answered", systemImage: "checkmark.circle.fill")
                                    .foregroundColor(.quizifyAccentGreen)
                            } else if index < viewModel.currentQuestionIndex {
                                Label("Not Answered", systemImage: "xmark.circle.fill")
                                    .foregroundColor(.quizifyRedError)
                            } else {
                                Label("Not Yet Reached", systemImage: "circle.dotted")
                                    .foregroundColor(.quizifyTextGray)
                            }
                        }
                        .font(.headline)
                    }
                }
            }
        }
        .padding(30)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
    }
}

struct QuestionCardView: View {
    let question: Question
    let selectedAnswer: String?
    let onSelectAnswer: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text(question.question)
                .font(.system(size: 24, weight: .semibold))
            
            if let imageUrl = question.image, !imageUrl.isEmpty, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { $0.resizable().aspectRatio(contentMode: .fit) } placeholder: { ProgressView() }
                    .frame(maxHeight: 300)
                    .cornerRadius(16)
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
        .frame(maxHeight: .infinity)
    }
}

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

struct QuestionNavigationView: View {
    let totalQuestions: Int
    @Binding var currentQuestionIndex: Int
    let answers: [String?]

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<totalQuestions, id: \.self) { index in
                        Button(action: {
                            withAnimation {
                                currentQuestionIndex = index
                            }
                        }) {
                            Text("\(index + 1)")
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(width: 44, height: 44)
                                .background(buttonBackground(for: index))
                                .foregroundColor(buttonForeground(for: index))
                                .cornerRadius(8)
                        }
                        .id(index)
                    }
                }
            }
            .onChange(of: currentQuestionIndex) {
                withAnimation {
                    proxy.scrollTo(currentQuestionIndex, anchor: .center)
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
            
            if viewModel.currentQuestionIndex == viewModel.totalQuestions - 1 {
                Button("Submit Test") { viewModel.isSubmitAlertShowing = true }
                    .font(.headline)
                    .padding()
                    .buttonStyle(FilledButtonStyle(color: .quizifyAccentGreen))
            } else {
                Button(action: { viewModel.nextQuestion() }) {
                    Label("Next", systemImage: "arrow.right.circle.fill")
                        .font(.headline)
                        .padding()
                }
                .buttonStyle(FilledButtonStyle(color: .quizifyPrimary))
            }
        }
    }
}

struct ScratchpadView: View {
    @State private var notes = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Label("Scratchpad", systemImage: "pencil.and.scribble")
                .font(.headline)
                .foregroundColor(.quizifyTextGray)
            
            TextEditor(text: $notes)
                .padding(10)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 5)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2)))
        }
        .frame(height: 200)
    }
}

// MARK: - Confirmation and Result Views
struct ExitTestConfirmationView: View {
    let onConfirmExit: () -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.orange)
                .padding(20)
                .background(Circle().fill(Color.orange.opacity(0.1)))

            VStack(spacing: 8) {
                Text("Leave Test?")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                Text("If you leave now, the test will be marked as missed. This action cannot be undone.")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
            }

            HStack(spacing: 20) {
                Button(action: onCancel) {
                    Text("Stay")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(OutlineButtonStyle(color: .white))

                Button(action: onConfirmExit) {
                    Label("Leave Test", systemImage: "door.left.hand.open")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(FilledButtonStyle(color: .quizifyRedError))
            }
            .padding(.top, 10)
        }
        .padding(40)
        .background(
            ZStack {
                Color.black.opacity(0.45)
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.quizifyRedError.opacity(0.5),
                        Color.quizifyDarkBackground.opacity(0.7)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                RoundedRectangle(cornerRadius: 25)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.4), Color.white.opacity(0.1)]), startPoint: .top, endPoint: .bottom), lineWidth: 1.5)
            }
        )
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 15)
        .padding(50)
        .frame(maxWidth: 600)
    }
}

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
                    .buttonStyle(FilledButtonStyle(color: .quizifyPrimary))
            }
            .padding(.top)
        }
    }
}
