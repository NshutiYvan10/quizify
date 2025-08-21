//
//  AttemptTestView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 12/08/2025.
//

//good but not yet perfect

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
            
            if showExitConfirmation {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                ExitTestConfirmationView(
                    onConfirmExit: { onFinish() },
                    onCancel: { showExitConfirmation = false }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: showExitConfirmation)
        .animation(.default, value: viewModel.isSubmitted)
    }
}

// MARK: - TestTakingView
struct TestTakingView: View {
    let test: TestDetails
    @ObservedObject var viewModel: AttemptTestViewModel
    let onExit: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            TestInfoHeader(test: test, onExit: onExit)

            HStack(alignment: .top, spacing: 50) { // increased horizontal spacing between main sections
                // Left Column
                VStack(alignment: .center, spacing: 40) {
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
                    
                    ScratchpadView()
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .top)

                // Right Column
                VStack(spacing: 30) {
                    TimerCardView(timeLeft: viewModel.timeLeft, totalTime: test.duration * 60)
                    QuestionStatusSummaryCard(viewModel: viewModel)
                }
                .frame(width: 380, alignment: .top)
            }
            .padding(30)
        }
    }
}

// Extension for computed properties
extension AttemptTestViewModel {
    var totalQuestions: Int { testDetails?.questions.count ?? 0 }
    var unansweredCount: Int { totalQuestions - answeredCount }
}

// MARK: - Header & Progress
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

// MARK: - Timer & Status Cards
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
        .padding(30)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, y: 5)
    }
}

// MARK: - Question Card & Options
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
                    .frame(maxHeight: 250)
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

// MARK: - Question Navigation
struct QuestionNavigationView: View {
    let totalQuestions: Int
    @Binding var currentQuestionIndex: Int
    let answers: [String?]

    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<totalQuestions, id: \.self) { index in
                Button(action: { withAnimation(.spring()) { currentQuestionIndex = index } }) {
                    ZStack {
                        Circle()
                            .fill(buttonFill(for: index))
                        Circle()
                            .stroke(buttonStroke(for: index), lineWidth: 2)
                        Text("\(index + 1)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(buttonForeground(for: index))
                    }
                    .frame(width: 50, height: 50)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(maxWidth: .infinity) // centers the row
    }

    private func buttonFill(for index: Int) -> Color {
        if currentQuestionIndex == index { return .quizifyPrimary }
        else if answers[index] != nil { return .quizifyAccentGreen }
        else { return .white }
    }

    private func buttonStroke(for index: Int) -> Color {
        if currentQuestionIndex == index { return .quizifyPrimary.opacity(0.5) }
        else if answers[index] == nil { return .quizifyLightGray }
        else { return .clear }
    }

    private func buttonForeground(for index: Int) -> Color {
        if currentQuestionIndex == index || answers[index] != nil { return .white }
        else { return .quizifyTextGray }
    }
}

// MARK: - Navigation Buttons
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

// MARK: - Scratchpad
struct ScratchpadView: View {
    @State private var notes = ""
    @State private var isBold = false
    @State private var isUnderline = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Label("Scratchpad", systemImage: "pencil.and.scribble")
                    .font(.headline)
                    .foregroundColor(.quizifyTextGray)
                Spacer()
                HStack {
                    Button(action: { isBold.toggle() }) {
                        Image(systemName: "bold")
                            .padding(8)
                            .background(isBold ? Color.quizifyPrimary.opacity(0.2) : Color.clear)
                            .cornerRadius(5)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { isUnderline.toggle() }) {
                        Image(systemName: "underline")
                            .padding(8)
                            .background(isUnderline ? Color.quizifyPrimary.opacity(0.2) : Color.clear)
                            .cornerRadius(5)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            TextEditor(text: $notes)
                .padding(10)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.05), radius: 5)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2)))
                .font(isBold ? .headline.bold() : .body)
                .underline(isUnderline)
                .frame(height: 150)
        }
    }
}

// MARK: - Exit Confirmation
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

// MARK: - Test Results Summary
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




