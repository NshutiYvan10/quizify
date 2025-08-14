//
//  TestsView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

//import SwiftUI
//
//// The TestsView provides a comprehensive list of all student tests,
//// categorized into upcoming, completed, and missed.
//struct TestsView: View {
//    // The ViewModel supplies the test data from the JSON files.
//    @StateObject private var viewModel = TestsViewModel()
//    // State to manage which category of tests is currently displayed.
//    @State private var selectedTab: TestTab = .upcoming
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 25) {
//                // MARK: - Header and Tab Picker
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text("My Tests")
//                            .font(.system(size: 28, weight: .bold))
//                        Text("View and manage all your upcoming and completed tests.")
//                            .font(.title3)
//                            .foregroundColor(.quizifyTextGray)
//                    }
//                    Spacer()
//                    // A segmented picker for switching between test categories.
//                    Picker("Test Status", selection: $selectedTab) {
//                        ForEach(TestTab.allCases) { tab in
//                            Text(tab.rawValue).tag(tab)
//                        }
//                    }
//                    .pickerStyle(SegmentedPickerStyle())
//                    .frame(maxWidth: 400)
//                }
//
//                // MARK: - Tests List
//                // A vertical stack to display the list of test cards.
//                VStack(spacing: 20) {
//                    let tests = currentTests()
//                    if tests.isEmpty {
//                        // A message to show when there are no tests in a category.
//                        Text("No tests in this category.")
//                            .foregroundColor(.gray)
//                            .font(.headline)
//                            .frame(maxWidth: .infinity, minHeight: 200)
//                    } else {
//                        // Loop through the tests for the selected category.
//                        ForEach(tests) { test in
//                            TestCardView(test: test)
//                        }
//                    }
//                }
//            }
//            .padding(30)
//        }
//    }
//    
//    // A helper function to get the correct list of tests based on the selected tab.
//    private func currentTests() -> [Test] {
//        switch selectedTab {
//        case .upcoming:
//            return viewModel.upcomingTests
//        case .completed:
//            return viewModel.completedTests
//        case .missed:
//            return viewModel.missedTests
//        case .all:
//            // Combine all lists for the "All" tab.
//            return viewModel.upcomingTests + viewModel.completedTests + viewModel.missedTests
//        }
//    }
//}
//
//// Enum defining the different categories for tests.
//enum TestTab: String, CaseIterable, Identifiable {
//    case upcoming = "Upcoming"
//    case completed = "Completed"
//    case missed = "Missed"
//    case all = "All Tests"
//    var id: String { self.rawValue }
//}
//
//// MARK: - TestCardView
//// A card that displays detailed information about a single test.
//struct TestCardView: View {
//    let test: Test
//    
//    // Determines the color of the status badge based on the test's status.
//    private var statusColor: Color {
//        switch test.status {
//        case "Upcoming": return .quizifyAccentBlue
//        case "Completed": return .quizifyAccentGreen
//        case "Missed": return .quizifyRedError
//        default: return .gray
//        }
//    }
//
//    var body: some View {
//        HStack(spacing: 20) {
//            // MARK: Main Info
//            VStack(alignment: .leading, spacing: 10) {
//                Text(test.title)
//                    .font(.title3)
//                    .fontWeight(.bold)
//                Text("\(test.className) • \(test.subject)")
//                    .font(.headline)
//                    .foregroundColor(.quizifyTextGray)
//                
//                HStack(spacing: 20) {
//                    Label(test.date, systemImage: "calendar")
//                    Label(test.time, systemImage: "clock")
//                    Label(test.duration, systemImage: "hourglass")
//                }
//                .font(.subheadline)
//                .foregroundColor(.quizifyTextGray)
//            }
//            
//            Spacer()
//            
//            // MARK: Status and Score
//            HStack(spacing: 20) {
//                // Display the score if the test is completed.
//                if let score = test.score {
//                    VStack {
//                        Text("Score")
//                            .font(.caption)
//                            .foregroundColor(.quizifyTextGray)
//                        Text("\(score)%")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                            .foregroundColor(statusColor)
//                    }
//                }
//                
//                // The status badge.
//                Text(test.status)
//                    .font(.headline)
//                    .fontWeight(.medium)
//                    .padding(.horizontal, 15)
//                    .padding(.vertical, 8)
//                    .background(statusColor.opacity(0.15))
//                    .foregroundColor(statusColor)
//                    .cornerRadius(20)
//            }
//            
//            // MARK: Action Button
//            Button(action: {}) {
//                HStack {
//                    Text(test.status == "Upcoming" ? "Take Test" : "View Results")
//                    Image(systemName: "arrow.right.circle.fill")
//                }
//            }
//            .buttonStyle(.borderedProminent)
//            .tint(.quizifyPrimary)
//            .disabled(test.status == "Missed") // Disable the button for missed tests.
//        }
//        .padding(20)
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(color: .black.opacity(0.05), radius: 5)
//    }
//}
//
//// MARK: - Preview
//struct TestsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestsView()
//    }
//}


//import SwiftUI
//
//// The TestsView allows a student to see all their assigned tests,
//// categorized by status. It serves as the main hub for test management.
//struct TestsView: View {
//    @StateObject private var viewModel = StudentTestsViewModel()
//    @State private var selectedTab: TestTab = .upcoming
//    @State private var selectedTest: StudentTest? = nil
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 25) {
//                // MARK: - Header
//                VStack(alignment: .leading) {
//                    Text("My Tests")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("View and manage all your tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Tab Picker
//                Picker("Test Status", selection: $selectedTab) {
//                    ForEach(TestTab.allCases) { tab in
//                        Text(tab.rawValue).tag(tab)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .frame(maxWidth: 500)
//
//                // MARK: - Tests Grid
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 380), spacing: 25)], spacing: 25) {
//                    let tests = currentTests()
//                    if tests.isEmpty {
//                        Text("No tests in this category.")
//                            .foregroundColor(.gray)
//                            .font(.headline)
//                            .frame(maxWidth: .infinity, minHeight: 200)
//                    } else {
//                        ForEach(tests) { test in
//                            TestCardView(test: test, onTakeTest: {
//                                selectedTest = test
//                            })
//                        }
//                    }
//                }
//            }
//            .padding(30)
//        }
//        .sheet(item: $selectedTest) { test in
//            // When a test is selected, the AttemptTestView is presented as a sheet.
//            AttemptTestView(testId: test.id)
//        }
//    }
//    
//    private func currentTests() -> [StudentTest] {
//        switch selectedTab {
//        case .upcoming: return viewModel.upcomingTests
//        case .completed: return viewModel.completedTests
//        case .missed: return viewModel.missedTests
//        case .all: return viewModel.upcomingTests + viewModel.completedTests + viewModel.missedTests
//        }
//    }
//}
//
//// Enum for the test categories.
//enum TestTab: String, CaseIterable, Identifiable {
//    case upcoming = "Upcoming"
//    case completed = "Completed"
//    case missed = "Missed"
//    case all = "All Tests"
//    var id: String { self.rawValue }
//}
//
//// MARK: - TestCardView
//// A card displaying a summary of a student's test.
//struct TestCardView: View {
//    let test: StudentTest
//    var onTakeTest: () -> Void
//    
//    private var statusColor: Color {
//        switch test.status {
//        case "Upcoming": return .quizifyAccentYellow
//        case "Completed": return .quizifyAccentGreen
//        case "Missed": return .quizifyRedError
//        default: return .gray
//        }
//    }
//    
//    private var buttonColor: Color {
//        test.status == "Upcoming" ? .quizifyPrimary : .quizifyAccentBlue
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            // Header
//            VStack(alignment: .leading, spacing: 15) {
//                HStack(alignment: .top) {
//                    VStack(alignment: .leading) {
//                        Text(test.title).font(.title3).fontWeight(.bold)
//                        Text(test.subject).font(.headline).foregroundColor(.gray)
//                    }
//                    Spacer()
//                    Menu {
//                        Button("View Test Details") {}
//                        Button("Go to Class") {}
//                    } label: {
//                        Image(systemName: "ellipsis.circle.fill")
//                            .font(.title2)
//                            .foregroundColor(.gray)
//                    }
//                }
//                
//                HStack {
//                    AsyncImage(url: URL(string: test.teacherAvatar ?? "")) { phase in
//                        if let image = phase.image {
//                            image.resizable().clipShape(Circle())
//                        } else {
//                            Image(systemName: "person.crop.circle.fill").resizable()
//                        }
//                    }
//                    .frame(width: 30, height: 30)
//                    Text(test.teacher).font(.subheadline).foregroundColor(.quizifyTextGray)
//                }
//                
//                HStack {
//                    InfoRow(icon: "book.closed.fill", text: test.className)
//                    InfoRow(icon: "hourglass", text: test.duration)
//                }
//                HStack {
//                    InfoRow(icon: "calendar", text: test.date)
//                    InfoRow(icon: "clock.fill", text: test.time)
//                }
//                
//                HStack {
//                    Badge(text: test.status, color: statusColor)
//                    if let score = test.score {
//                        Badge(text: "Score: \(score)%", color: .quizifyAccentBlue)
//                    }
//                }
//            }
//            .padding(20)
//            
//            Spacer()
//            
//            // Footer Button
//            Button(action: onTakeTest) {
//                Label(test.status == "Upcoming" ? "Take Test" : "View Results", systemImage: "eye.fill")
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity)
//            }
//            .buttonStyle(OutlineButtonStyle(color: buttonColor))
//            .padding([.horizontal, .bottom], 20)
//            .disabled(test.status == "Missed")
//        }
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// MARK: - Helper Views
//fileprivate struct InfoRow: View {
//    let icon: String
//    let text: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon).foregroundColor(.gray).frame(width: 20)
//            Text(text).foregroundColor(.gray)
//            Spacer()
//        }
//    }
//}
//
//fileprivate struct Badge: View {
//    let text: String
//    let color: Color
//    
//    var body: some View {
//        Text(text)
//            .font(.caption)
//            .fontWeight(.medium)
//            .padding(.horizontal, 10)
//            .padding(.vertical, 4)
//            .background(color.opacity(0.15))
//            .foregroundColor(color)
//            .cornerRadius(15)
//    }
//}




// was lowkey working


//import SwiftUI
//
//// The TestsView allows a student to see all their assigned tests,
//// categorized by status. It serves as the main hub for test management.
//struct TestsView: View {
//    @StateObject private var viewModel = StudentTestsViewModel()
//    @State private var selectedTab: TestTab = .upcoming
//    @State private var selectedTest: Test? = nil
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 25) {
//                // MARK: - Header
//                VStack(alignment: .leading) {
//                    Text("My Tests")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("View and manage all your tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Tab Picker
//                Picker("Test Status", selection: $selectedTab) {
//                    ForEach(TestTab.allCases) { tab in
//                        Text(tab.rawValue).tag(tab)
//                    }
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .frame(maxWidth: 500)
//
//                // MARK: - Tests Grid
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 380), spacing: 25)], spacing: 25) {
//                    let tests = currentTests()
//                    if tests.isEmpty {
//                        Text("No tests in this category.")
//                            .foregroundColor(.gray)
//                            .font(.headline)
//                            .frame(maxWidth: .infinity, minHeight: 200)
//                    } else {
//                        ForEach(tests) { test in
//                            TestCardView(test: test, onTakeTest: {
//                                selectedTest = test
//                            })
//                        }
//                    }
//                }
//            }
//            .padding(30)
//        }
//        .sheet(item: $selectedTest) { test in
//            // When a test is selected, the AttemptTestView is presented as a sheet.
//            AttemptTestView(testId: test.id)
//        }
//    }
//    
//    private func currentTests() -> [Test] {
//        switch selectedTab {
//        case .upcoming: return viewModel.upcomingTests
//        case .completed: return viewModel.completedTests
//        case .missed: return viewModel.missedTests
//        case .all: return viewModel.upcomingTests + viewModel.completedTests + viewModel.missedTests
//        }
//    }
//}
//
//// Enum for the test categories.
//enum TestTab: String, CaseIterable, Identifiable {
//    case upcoming = "Upcoming"
//    case completed = "Completed"
//    case missed = "Missed"
//    case all = "All Tests"
//    var id: String { self.rawValue }
//}
//
//// MARK: - TestCardView
//// A card displaying a summary of a student's test.
//struct TestCardView: View {
//    let test: Test
//    var onTakeTest: () -> Void
//    
//    private var statusColor: Color {
//        switch test.status {
//        case "Upcoming": return .quizifyAccentYellow
//        case "Completed": return .quizifyAccentGreen
//        case "Missed": return .quizifyRedError
//        default: return .gray
//        }
//    }
//    
//    private var buttonColor: Color {
//        test.status == "Upcoming" ? .quizifyPrimary : .quizifyAccentBlue
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            // Header
//            VStack(alignment: .leading, spacing: 15) {
//                HStack(alignment: .top) {
//                    VStack(alignment: .leading) {
//                        Text(test.title).font(.title3).fontWeight(.bold)
//                        Text(test.subject).font(.headline).foregroundColor(.gray)
//                    }
//                    Spacer()
//                    Menu {
//                        Button("View Test Details") {}
//                        Button("Go to Class") {}
//                    } label: {
//                        Image(systemName: "ellipsis.circle.fill")
//                            .font(.title2)
//                            .foregroundColor(.gray)
//                    }
//                }
//                
//                HStack {
//                    AsyncImage(url: URL(string: test.teacherAvatar ?? "")) { phase in
//                        if let image = phase.image {
//                            image.resizable().clipShape(Circle())
//                        } else {
//                            Image(systemName: "person.crop.circle.fill").resizable()
//                        }
//                    }
//                    .frame(width: 30, height: 30)
//                    Text(test.teacher).font(.subheadline).foregroundColor(.quizifyTextGray)
//                }
//                
//                HStack {
//                    InfoRow(icon: "book.closed.fill", text: test.className)
//                    InfoRow(icon: "hourglass", text: test.duration)
//                }
//                HStack {
//                    InfoRow(icon: "calendar", text: test.date)
//                    InfoRow(icon: "clock.fill", text: test.time)
//                }
//                
//                HStack {
//                    Badge(text: test.status, color: statusColor)
//                    if let score = test.score {
//                        Badge(text: "Score: \(score)%", color: .quizifyAccentBlue)
//                    }
//                }
//            }
//            .padding(20)
//            
//            Spacer()
//            
//            // Footer Button
//            Button(action: onTakeTest) {
//                Label(test.status == "Upcoming" ? "Take Test" : "View Results", systemImage: "eye.fill")
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity)
//            }
//            .buttonStyle(OutlineButtonStyle(color: buttonColor))
//            .padding([.horizontal, .bottom], 20)
//            .disabled(test.status == "Missed")
//        }
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// MARK: - Helper Views
//fileprivate struct InfoRow: View {
//    let icon: String
//    let text: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon).foregroundColor(.gray).frame(width: 20)
//            Text(text).foregroundColor(.gray)
//            Spacer()
//        }
//    }
//}
//
//fileprivate struct Badge: View {
//    let text: String
//    let color: Color
//    
//    var body: some View {
//        Text(text)
//            .font(.caption)
//            .fontWeight(.medium)
//            .padding(.horizontal, 10)
//            .padding(.vertical, 4)
//            .background(color.opacity(0.15))
//            .foregroundColor(color)
//            .cornerRadius(15)
//    }
//}



// it works well but with a few design issues

//import SwiftUI
//
//// The TestsView allows a student to see all their assigned tests,
//// categorized by status. It serves as the main hub for test management.
//struct TestsView: View {
//    @StateObject private var viewModel = StudentTestsViewModel()
//    @State private var selectedTab: TestTab = .upcoming
//    @State private var selectedTest: Test? = nil
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 25) {
//                // MARK: - Header
//                VStack(alignment: .leading) {
//                    Text("My Tests")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("View and manage all your tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Custom Tab View
//                // This custom implementation matches the styling of the original TypeScript version.
//                HStack {
//                    Spacer()
//                    HStack(spacing: 0) {
//                        ForEach(TestTab.allCases) { tab in
//                            TabButton(tab: tab, selectedTab: $selectedTab)
//                        }
//                    }
//                    .background(Color.quizifyPrimary.opacity(0.1))
//                    .cornerRadius(8)
//                    .frame(maxWidth: 600)
//                    Spacer()
//                }
//
//
//                // MARK: - Tests Grid
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 400), spacing: 25)], spacing: 25) {
//                    let tests = currentTests()
//                    if tests.isEmpty {
//                        // Placeholder for empty tabs, matching the original design.
//                        VStack(spacing: 10) {
//                            Image(systemName: "doc.text.magnifyingglass")
//                                .font(.largeTitle)
//                                .foregroundColor(.gray.opacity(0.5))
//                            Text("No tests in this category.")
//                                .foregroundColor(.gray)
//                                .font(.headline)
//                        }
//                        .frame(maxWidth: .infinity, minHeight: 200)
//                        .background(Color.gray.opacity(0.05))
//                        .cornerRadius(16)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
//                                .foregroundColor(.gray.opacity(0.2))
//                        )
//                    } else {
//                        ForEach(tests) { test in
//                            StudentTestCardView(test: test, onTakeTest: {
//                                selectedTest = test
//                            })
//                        }
//                    }
//                }
//            }
//            .padding(30)
//        }
//        .sheet(item: $selectedTest) { test in
//            // When a test is selected, the AttemptTestView is presented as a sheet.
//            AttemptTestView(testId: test.id)
//        }
//    }
//    
//    private func currentTests() -> [Test] {
//        switch selectedTab {
//        case .upcoming: return viewModel.upcomingTests
//        case .completed: return viewModel.completedTests
//        case .missed: return viewModel.missedTests
//        case .all: return viewModel.upcomingTests + viewModel.completedTests + viewModel.missedTests
//        }
//    }
//}
//
//// Enum for the test categories, now with associated colors for the tabs.
//enum TestTab: String, CaseIterable, Identifiable {
//    case upcoming = "Upcoming"
//    case completed = "Completed"
//    case missed = "Missed"
//    case all = "All Tests"
//    var id: String { self.rawValue }
//    
//    var activeColor: Color {
//        switch self {
//        case .upcoming: return .quizifyPrimary
//        case .completed: return .quizifyAccentGreen
//        case .missed: return .quizifyRedError
//        case .all: return .quizifyAccentBlue
//        }
//    }
//}
//
//// MARK: - TabButton
//// A dedicated view for the custom tab buttons to keep the main view clean.
//struct TabButton: View {
//    let tab: TestTab
//    @Binding var selectedTab: TestTab
//    
//    var body: some View {
//        Button(action: {
//            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
//                selectedTab = tab
//            }
//        }) {
//            Text(tab.rawValue)
//                .font(.headline)
//                .fontWeight(.semibold)
//                .padding(.vertical, 12)
//                .frame(maxWidth: .infinity)
//                .background(
//                    ZStack {
//                        if selectedTab == tab {
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(tab.activeColor)
//                                .shadow(radius: 3, y: 2)
//                        }
//                    }
//                )
//                .foregroundColor(selectedTab == tab ? .white : .primary)
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//
//// MARK: - StudentTestCardView
//// A card displaying a summary of a student's test, redesigned to match the TypeScript version.
//struct StudentTestCardView: View {
//    let test: Test
//    var onTakeTest: () -> Void
//    
//    private var statusColor: Color {
//        switch test.status {
//        case "Upcoming": return .quizifyAccentYellow
//        case "Completed": return .quizifyAccentGreen
//        case "Missed": return .quizifyRedError
//        default: return .gray
//        }
//    }
//    
//    private var buttonColor: Color {
//        test.status == "Upcoming" ? .quizifyPrimary : .quizifyAccentBlue
//    }
//    
//    private var buttonText: String {
//        switch test.status {
//        case "Upcoming": return "Take Test"
//        case "Completed": return "View Results"
//        default: return "Missed"
//        }
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            // Header
//            VStack(alignment: .leading, spacing: 18) {
//                HStack(alignment: .top) {
//                    VStack(alignment: .leading) {
//                        Text(test.title).font(.title2).fontWeight(.bold).lineLimit(1)
//                        Text(test.subject).font(.title3).foregroundColor(.gray)
//                    }
//                    Spacer()
//                    Menu {
//                        Button("View Test Details") {}
//                        Button("Go to Class") {}
//                    } label: {
//                        Image(systemName: "ellipsis")
//                            .font(.title2)
//                            .foregroundColor(.gray)
//                            .padding(5)
//                    }
//                    .frame(width: 40, height: 40)
//                    .contentShape(Rectangle())
//                }
//                
//                HStack {
//                    AsyncImage(url: URL(string: test.teacherAvatar ?? "")) { phase in
//                        if let image = phase.image {
//                            image.resizable().clipShape(Circle())
//                        } else {
//                            Image(systemName: "person.crop.circle.fill").resizable()
//                        }
//                    }
//                    .frame(width: 30, height: 30)
//                    Text(test.teacher).font(.headline).foregroundColor(.quizifyTextGray)
//                }
//                
//                // Grid for test details, matching the 2x2 layout.
//                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
//                    TestCardInfoRow(icon: "book.closed.fill", text: test.className)
//                    TestCardInfoRow(icon: "hourglass", text: test.duration)
//                    TestCardInfoRow(icon: "calendar", text: test.date)
//                    TestCardInfoRow(icon: "clock.fill", text: test.time)
//                }
//                
//                HStack {
//                    TestCardBadge(text: test.status, color: statusColor)
//                    if let score = test.score {
//                        TestCardBadge(text: "Score: \(score)%", color: .quizifyAccentBlue)
//                    }
//                    Spacer()
//                }
//            }
//            .padding(25)
//            
//            Spacer()
//            
//            // Footer Button, styled to match the original design.
//            Button(action: onTakeTest) {
//                Label(buttonText, systemImage: "eye.fill")
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 10)
//            }
//            .buttonStyle(OutlineButtonStyle(color: buttonColor))
//            .padding([.horizontal, .bottom], 25)
//            .disabled(test.status == "Missed")
//        }
//        .frame(minHeight: 340)
//        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// MARK: - Helper Views
//// Renamed to avoid conflicts with other views.
//fileprivate struct TestCardInfoRow: View {
//    let icon: String
//    let text: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon).foregroundColor(.gray).frame(width: 20)
//            Text(text).font(.subheadline).foregroundColor(.gray)
//            Spacer()
//        }
//    }
//}
//
//fileprivate struct TestCardBadge: View {
//    let text: String
//    let color: Color
//    
//    var body: some View {
//        Text(text)
//            .font(.subheadline)
//            .fontWeight(.medium)
//            .padding(.horizontal, 12)
//            .padding(.vertical, 5)
//            .background(color.opacity(0.15))
//            .foregroundColor(color)
//            .cornerRadius(15)
//    }
//}




//Good but not yet perfect

//import SwiftUI
//
//// The TestsView allows a student to see all their assigned tests,
//// categorized by status. It serves as the main hub for test management.
//struct TestsView: View {
//    @StateObject private var viewModel = StudentTestsViewModel()
//    @State private var selectedTab: TestTab = .upcoming
//    @State private var selectedTest: Test? = nil
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 25) {
//                // MARK: - Header
//                VStack(alignment: .leading) {
//                    Text("My Tests")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("View and manage all your tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Custom Tab View
//                // This custom implementation matches the styling of the original TypeScript version.
//                HStack {
//                    Spacer()
//                    HStack(spacing: 0) {
//                        ForEach(TestTab.allCases) { tab in
//                            TabButton(tab: tab, selectedTab: $selectedTab)
//                        }
//                    }
//                    .background(Color.quizifyPrimary.opacity(0.1))
//                    .cornerRadius(8)
//                    .frame(maxWidth: 600)
//                    Spacer()
//                }
//
//
//                // MARK: - Tests Grid
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 400), spacing: 25)], spacing: 25) {
//                    let tests = currentTests()
//                    if tests.isEmpty {
//                        // Placeholder for empty tabs, matching the original design.
//                        VStack(spacing: 10) {
//                            Image(systemName: "doc.text.magnifyingglass")
//                                .font(.largeTitle)
//                                .foregroundColor(.gray.opacity(0.5))
//                            Text("No tests in this category.")
//                                .foregroundColor(.gray)
//                                .font(.headline)
//                        }
//                        .frame(maxWidth: .infinity, minHeight: 200)
//                        .background(Color.gray.opacity(0.05))
//                        .cornerRadius(16)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
//                                .foregroundColor(.gray.opacity(0.2))
//                        )
//                    } else {
//                        ForEach(tests) { test in
//                            StudentTestCardView(test: test, onTakeTest: {
//                                selectedTest = test
//                            })
//                        }
//                    }
//                }
//            }
//            .padding(30)
//        }
//        .sheet(item: $selectedTest) { test in
//            // When a test is selected, the AttemptTestView is presented as a sheet.
//            AttemptTestView(testId: test.id)
//        }
//    }
//    
//    private func currentTests() -> [Test] {
//        switch selectedTab {
//        case .upcoming: return viewModel.upcomingTests
//        case .completed: return viewModel.completedTests
//        case .missed: return viewModel.missedTests
//        case .all: return viewModel.upcomingTests + viewModel.completedTests + viewModel.missedTests
//        }
//    }
//}
//
//// Enum for the test categories, now with associated colors for the tabs.
//enum TestTab: String, CaseIterable, Identifiable {
//    case upcoming = "Upcoming"
//    case completed = "Completed"
//    case missed = "Missed"
//    case all = "All Tests"
//    var id: String { self.rawValue }
//    
//    var activeColor: Color {
//        switch self {
//        case .upcoming: return .quizifyPrimary
//        case .completed: return .quizifyAccentGreen
//        case .missed: return .quizifyRedError
//        case .all: return .quizifyAccentBlue
//        }
//    }
//}
//
//// MARK: - TabButton
//// A dedicated view for the custom tab buttons to keep the main view clean.
//struct TabButton: View {
//    let tab: TestTab
//    @Binding var selectedTab: TestTab
//    
//    var body: some View {
//        Button(action: {
//            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
//                selectedTab = tab
//            }
//        }) {
//            Text(tab.rawValue)
//                .font(.headline)
//                .fontWeight(.semibold)
//                .padding(.vertical, 12)
//                .frame(maxWidth: .infinity)
//                .background(
//                    ZStack {
//                        if selectedTab == tab {
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(tab.activeColor)
//                                .shadow(radius: 3, y: 2)
//                        }
//                    }
//                )
//                .foregroundColor(selectedTab == tab ? .white : .primary)
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//
//// MARK: - StudentTestCardView
//// A card displaying a summary of a student's test, redesigned to be more professional and visually appealing.
//struct StudentTestCardView: View {
//    let test: Test
//    var onTakeTest: () -> Void
//    
//    private var statusColor: Color {
//        switch test.status {
//        case "Upcoming": return .quizifyAccentYellow
//        case "Completed": return .quizifyAccentGreen
//        case "Missed": return .quizifyRedError
//        default: return .gray
//        }
//    }
//    
//    private var buttonColor: Color {
//        test.status == "Upcoming" ? .quizifyPrimary : .quizifyAccentBlue
//    }
//    
//    private var buttonText: String {
//        switch test.status {
//        case "Upcoming": return "Take Test"
//        case "Completed": return "View Results"
//        default: return "Missed"
//        }
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 15) {
//            // Top section with title and teacher info
//            VStack(alignment: .leading, spacing: 12) {
//                VStack(alignment: .leading) {
//                    Text(test.title).font(.system(size: 26, weight: .bold)).lineLimit(1)
//                    Text(test.subject).font(.system(size: 20)).foregroundColor(.gray)
//                }
//                
//                HStack {
//                    AsyncImage(url: URL(string: test.teacherAvatar ?? "")) { phase in
//                        if let image = phase.image {
//                            image.resizable().clipShape(Circle())
//                        } else {
//                            Image(systemName: "person.crop.circle.fill").resizable()
//                        }
//                    }
//                    .frame(width: 30, height: 30)
//                    Text(test.teacher).font(.headline).foregroundColor(.quizifyTextGray)
//                }
//            }
//            
//            // Middle section with test details grid
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
//                TestCardInfoRow(icon: "book.closed.fill", text: test.className)
//                TestCardInfoRow(icon: "hourglass", text: test.duration)
//                TestCardInfoRow(icon: "calendar", text: test.date)
//                TestCardInfoRow(icon: "clock.fill", text: test.time)
//            }
//            
//            Spacer()
//            
//            // Bottom section with status badges and action button
//            VStack(spacing: 15) {
//                HStack {
//                    TestCardBadge(text: test.status, color: statusColor)
//                    if let score = test.score {
//                        TestCardBadge(text: "Score: \(score)%", color: .quizifyAccentBlue)
//                    }
//                    Spacer()
//                }
//                
//                Button(action: onTakeTest) {
//                    Label(buttonText, systemImage: "eye.fill")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 10)
//                }
//                .buttonStyle(OutlineButtonStyle(color: buttonColor))
//                .disabled(test.status == "Missed")
//            }
//        }
//        .padding(25)
//        .frame(minHeight: 340)
//        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// MARK: - Helper Views
//// Renamed to avoid conflicts with other views.
//fileprivate struct TestCardInfoRow: View {
//    let icon: String
//    let text: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .font(.headline)
//                .foregroundColor(.gray)
//                .frame(width: 20)
//            Text(text)
//                .font(.headline)
//                .fontWeight(.medium)
//                .foregroundColor(.quizifyTextGray)
//            Spacer()
//        }
//    }
//}
//
//fileprivate struct TestCardBadge: View {
//    let text: String
//    let color: Color
//    
//    var body: some View {
//        Text(text)
//            .font(.subheadline)
//            .fontWeight(.medium)
//            .padding(.horizontal, 12)
//            .padding(.vertical, 5)
//            .background(color.opacity(0.15))
//            .foregroundColor(color)
//            .cornerRadius(15)
//    }
//}



// close to perfection but not perfection

//
//import SwiftUI
//
//// The TestsView allows a student to see all their assigned tests,
//// categorized by status. It serves as the main hub for test management.
//struct TestsView: View {
//    @StateObject private var viewModel = StudentTestsViewModel()
//    @State private var selectedTab: TestTab = .upcoming
//    @State private var selectedTest: Test? = nil
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 25) {
//                // MARK: - Header
//                VStack(alignment: .leading) {
//                    Text("My Tests")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("View and manage all your tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Custom Tab View
//                // This custom implementation matches the styling of the original TypeScript version.
//                HStack {
//                    Spacer()
//                    HStack(spacing: 0) {
//                        ForEach(TestTab.allCases) { tab in
//                            TabButton(tab: tab, selectedTab: $selectedTab)
//                        }
//                    }
//                    .background(Color.quizifyPrimary.opacity(0.1))
//                    .cornerRadius(8)
//                    .frame(maxWidth: 600)
//                    Spacer()
//                }
//
//
//                // MARK: - Tests Grid
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 400), spacing: 25)], spacing: 25) {
//                    let tests = currentTests()
//                    if tests.isEmpty {
//                        // Placeholder for empty tabs, matching the original design.
//                        VStack(spacing: 10) {
//                            Image(systemName: "doc.text.magnifyingglass")
//                                .font(.largeTitle)
//                                .foregroundColor(.gray.opacity(0.5))
//                            Text("No tests in this category.")
//                                .foregroundColor(.gray)
//                                .font(.headline)
//                        }
//                        .frame(maxWidth: .infinity, minHeight: 200)
//                        .background(Color.gray.opacity(0.05))
//                        .cornerRadius(16)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
//                                .foregroundColor(.gray.opacity(0.2))
//                        )
//                    } else {
//                        ForEach(tests) { test in
//                            StudentTestCardView(test: test, onTakeTest: {
//                                selectedTest = test
//                            })
//                        }
//                    }
//                }
//            }
//            .padding(30)
//        }
//        .sheet(item: $selectedTest) { test in
//            // When a test is selected, the AttemptTestView is presented as a sheet.
//            AttemptTestView(testId: test.id)
//        }
//    }
//    
//    private func currentTests() -> [Test] {
//        switch selectedTab {
//        case .upcoming: return viewModel.upcomingTests
//        case .completed: return viewModel.completedTests
//        case .missed: return viewModel.missedTests
//        case .all: return viewModel.upcomingTests + viewModel.completedTests + viewModel.missedTests
//        }
//    }
//}
//
//// Enum for the test categories, now with associated colors for the tabs.
//enum TestTab: String, CaseIterable, Identifiable {
//    case upcoming = "Upcoming"
//    case completed = "Completed"
//    case missed = "Missed"
//    case all = "All Tests"
//    var id: String { self.rawValue }
//    
//    var activeColor: Color {
//        switch self {
//        case .upcoming: return .quizifyPrimary
//        case .completed: return .quizifyAccentGreen
//        case .missed: return .quizifyRedError
//        case .all: return .quizifyAccentBlue
//        }
//    }
//}
//
//// MARK: - TabButton
//// A dedicated view for the custom tab buttons to keep the main view clean.
//struct TabButton: View {
//    let tab: TestTab
//    @Binding var selectedTab: TestTab
//    
//    var body: some View {
//        Button(action: {
//            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
//                selectedTab = tab
//            }
//        }) {
//            Text(tab.rawValue)
//                .font(.headline)
//                .fontWeight(.semibold)
//                .padding(.vertical, 12)
//                .frame(maxWidth: .infinity)
//                .background(
//                    ZStack {
//                        if selectedTab == tab {
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(tab.activeColor)
//                                .shadow(radius: 3, y: 2)
//                        }
//                    }
//                )
//                .foregroundColor(selectedTab == tab ? .white : .primary)
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//
//// MARK: - StudentTestCardView
//// A card displaying a summary of a student's test, redesigned to be more professional and visually appealing.
//struct StudentTestCardView: View {
//    let test: Test
//    var onTakeTest: () -> Void
//    
//    private var statusColor: Color {
//        switch test.status {
//        case "Upcoming": return .quizifyAccentYellow
//        case "Completed": return .quizifyAccentGreen
//        case "Missed": return .quizifyRedError
//        default: return .gray
//        }
//    }
//    
//    private var buttonColor: Color {
//        test.status == "Upcoming" ? .quizifyPrimary : .quizifyAccentBlue
//    }
//    
//    private var buttonText: String {
//        switch test.status {
//        case "Upcoming": return "Take Test"
//        case "Completed": return "View Results"
//        default: return "Missed"
//        }
//    }
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            // Top section with title and teacher info
//            VStack(alignment: .leading, spacing: 12) {
//                VStack(alignment: .leading) {
//                    Text(test.title).font(.system(size: 26, weight: .bold)).lineLimit(1)
//                    Text(test.subject).font(.system(size: 20)).foregroundColor(.gray)
//                }
//                
//                HStack {
//                    AsyncImage(url: URL(string: test.teacherAvatar ?? "")) { phase in
//                        if let image = phase.image {
//                            image.resizable().clipShape(Circle())
//                        } else {
//                            Image(systemName: "person.crop.circle.fill").resizable()
//                        }
//                    }
//                    .frame(width: 30, height: 30)
//                    Text(test.teacher).font(.headline).foregroundColor(.quizifyTextGray)
//                }
//            }
//            
//            Spacer()
//            
//            // Middle section with test details grid
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
//                TestCardInfoRow(icon: "book.closed.fill", text: test.className)
//                TestCardInfoRow(icon: "hourglass", text: test.duration)
//                TestCardInfoRow(icon: "calendar", text: test.date)
//                TestCardInfoRow(icon: "clock.fill", text: test.time)
//            }
//            
//            Spacer()
//            
//            // Bottom section with status badges and action button
//            VStack(spacing: 15) {
//                HStack {
//                    TestCardBadge(text: test.status, color: statusColor)
//                    if let score = test.score {
//                        TestCardBadge(text: "Score: \(score)%", color: .quizifyAccentBlue)
//                    }
//                    Spacer()
//                }
//                
//                Button(action: onTakeTest) {
//                    Label(buttonText, systemImage: "eye.fill")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 10)
//                }
//                .buttonStyle(OutlineButtonStyle(color: buttonColor))
//                .disabled(test.status == "Missed")
//            }
//        }
//        .padding(25)
//        .frame(minHeight: 340)
//        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// MARK: - Helper Views
//// Renamed to avoid conflicts with other views.
//fileprivate struct TestCardInfoRow: View {
//    let icon: String
//    let text: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .font(.headline)
//                .foregroundColor(.gray)
//                .frame(width: 20)
//            Text(text)
//                .font(.headline)
//                .fontWeight(.medium)
//                .foregroundColor(.quizifyTextGray)
//            Spacer()
//        }
//    }
//}
//
//fileprivate struct TestCardBadge: View {
//    let text: String
//    let color: Color
//    
//    var body: some View {
//        Text(text)
//            .font(.subheadline)
//            .fontWeight(.medium)
//            .padding(.horizontal, 12)
//            .padding(.vertical, 5)
//            .background(color.opacity(0.15))
//            .foregroundColor(color)
//            .cornerRadius(15)
//    }
//}


// this will do but not satisfied yet

//import SwiftUI
//
//// The TestsView allows a student to see all their assigned tests,
//// categorized by status. It serves as the main hub for test management.
//struct TestsView: View {
//    @StateObject private var viewModel = StudentTestsViewModel()
//    @State private var selectedTab: TestTab = .upcoming
//    @State private var selectedTest: Test? = nil
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 25) {
//                // MARK: - Header
//                VStack(alignment: .leading) {
//                    Text("My Tests")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("View and manage all your tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Custom Tab View
//                // This custom implementation matches the styling of the original TypeScript version.
//                HStack {
//                    Spacer()
//                    HStack(spacing: 0) {
//                        ForEach(TestTab.allCases) { tab in
//                            TabButton(tab: tab, selectedTab: $selectedTab)
//                        }
//                    }
//                    .background(Color.quizifyPrimary.opacity(0.1))
//                    .cornerRadius(8)
//                    .frame(maxWidth: 600)
//                    Spacer()
//                }
//
//
//                // MARK: - Tests Grid
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 400), spacing: 25)], spacing: 25) {
//                    let tests = currentTests()
//                    if tests.isEmpty {
//                        // Placeholder for empty tabs, matching the original design.
//                        VStack(spacing: 10) {
//                            Image(systemName: "doc.text.magnifyingglass")
//                                .font(.largeTitle)
//                                .foregroundColor(.gray.opacity(0.5))
//                            Text("No tests in this category.")
//                                .foregroundColor(.gray)
//                                .font(.headline)
//                        }
//                        .frame(maxWidth: .infinity, minHeight: 200)
//                        .background(Color.gray.opacity(0.05))
//                        .cornerRadius(16)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
//                                .foregroundColor(.gray.opacity(0.2))
//                        )
//                    } else {
//                        ForEach(tests) { test in
//                            StudentTestCardView(test: test, onTakeTest: {
//                                selectedTest = test
//                            })
//                        }
//                    }
//                }
//            }
//            .padding(30)
//        }
//        .sheet(item: $selectedTest) { test in
//            // When a test is selected, the AttemptTestView is presented as a sheet.
//            AttemptTestView(testId: test.id)
//        }
//    }
//    
//    private func currentTests() -> [Test] {
//        switch selectedTab {
//        case .upcoming: return viewModel.upcomingTests
//        case .completed: return viewModel.completedTests
//        case .missed: return viewModel.missedTests
//        case .all: return viewModel.upcomingTests + viewModel.completedTests + viewModel.missedTests
//        }
//    }
//}
//
//// Enum for the test categories, now with associated colors for the tabs.
//enum TestTab: String, CaseIterable, Identifiable {
//    case upcoming = "Upcoming"
//    case completed = "Completed"
//    case missed = "Missed"
//    case all = "All Tests"
//    var id: String { self.rawValue }
//    
//    var activeColor: Color {
//        switch self {
//        case .upcoming: return .quizifyPrimary
//        case .completed: return .quizifyAccentGreen
//        case .missed: return .quizifyRedError
//        case .all: return .quizifyAccentBlue
//        }
//    }
//}
//
//// MARK: - TabButton
//// A dedicated view for the custom tab buttons to keep the main view clean.
//struct TabButton: View {
//    let tab: TestTab
//    @Binding var selectedTab: TestTab
//    
//    var body: some View {
//        Button(action: {
//            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
//                selectedTab = tab
//            }
//        }) {
//            Text(tab.rawValue)
//                .font(.headline)
//                .fontWeight(.semibold)
//                .padding(.vertical, 12)
//                .frame(maxWidth: .infinity)
//                .background(
//                    ZStack {
//                        if selectedTab == tab {
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(tab.activeColor)
//                                .shadow(radius: 3, y: 2)
//                        }
//                    }
//                )
//                .foregroundColor(selectedTab == tab ? .white : .primary)
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//
//// MARK: - StudentTestCardView
//// A card displaying a summary of a student's test, redesigned to be more professional and visually appealing.
//struct StudentTestCardView: View {
//    let test: Test
//    var onTakeTest: () -> Void
//    
//    private var statusColor: Color {
//        switch test.status {
//        case "Upcoming": return .quizifyAccentYellow
//        case "Completed": return .quizifyAccentGreen
//        case "Missed": return .quizifyRedError
//        default: return .gray
//        }
//    }
//    
//    private var buttonColor: Color {
//        test.status == "Upcoming" ? .quizifyPrimary : .quizifyAccentBlue
//    }
//    
//    private var buttonText: String {
//        switch test.status {
//        case "Upcoming": return "Take Test"
//        case "Completed": return "View Results"
//        default: return "Missed"
//        }
//    }
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            // Top section with title and teacher info
//            VStack(alignment: .leading, spacing: 12) {
//                VStack(alignment: .leading) {
//                    Text(test.title).font(.system(size: 22, weight: .bold)).lineLimit(1)
//                    Text(test.subject).font(.system(size: 17)).foregroundColor(.gray)
//                }
//                
//                HStack {
//                    AsyncImage(url: URL(string: test.teacherAvatar ?? "")) { phase in
//                        if let image = phase.image {
//                            image.resizable().clipShape(Circle())
//                        } else {
//                            Image(systemName: "person.crop.circle.fill").resizable()
//                        }
//                    }
//                    .frame(width: 30, height: 30)
//                    Text(test.teacher).font(.headline).foregroundColor(.quizifyTextGray)
//                }
//            }
//            
//            Spacer()
//            
//            // Middle section with test details grid
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
//                TestCardInfoRow(icon: "book.closed.fill", text: test.className, color: .quizifyPrimary)
//                TestCardInfoRow(icon: "hourglass", text: test.duration, color: .quizifyAccentYellow)
//                TestCardInfoRow(icon: "calendar", text: test.date, color: .quizifyAccentBlue)
//                TestCardInfoRow(icon: "clock.fill", text: test.time, color: .quizifyAccentGreen)
//            }
//            
//            Spacer()
//            
//            // Bottom section with status badges and action button
//            VStack(spacing: 15) {
//                HStack {
//                    TestCardBadge(text: test.status, color: statusColor)
//                    if let score = test.score {
//                        TestCardBadge(text: "Score: \(score)%", color: .quizifyAccentBlue)
//                    }
//                    Spacer()
//                }
//                
//                Button(action: onTakeTest) {
//                    Label(buttonText, systemImage: "eye.fill")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 10)
//                }
//                .buttonStyle(OutlineButtonStyle(color: buttonColor))
//                .disabled(test.status == "Missed")
//            }
//        }
//        .padding(25)
//        .frame(minHeight: 340)
//        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// MARK: - Helper Views
//// Renamed to avoid conflicts with other views.
//fileprivate struct TestCardInfoRow: View {
//    let icon: String
//    let text: String
//    let color: Color
//
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .font(.headline)
//                .foregroundColor(color)
//                .frame(width: 20)
//            Text(text)
//                .font(.headline)
//                .fontWeight(.medium)
//                .foregroundColor(.quizifyTextGray)
//            Spacer()
//        }
//    }
//}
//
//fileprivate struct TestCardBadge: View {
//    let text: String
//    let color: Color
//    
//    var body: some View {
//        Text(text)
//            .font(.subheadline)
//            .fontWeight(.medium)
//            .padding(.horizontal, 12)
//            .padding(.vertical, 5)
//            .background(color.opacity(0.15))
//            .foregroundColor(color)
//            .cornerRadius(15)
//    }
//}


// niyi ntacyo itwaye

//import SwiftUI
//
//// The TestsView allows a student to see all their assigned tests,
//// categorized by status. It serves as the main hub for test management.
//struct TestsView: View {
//    @StateObject private var viewModel = StudentTestsViewModel()
//    @State private var selectedTab: TestTab = .upcoming
//    @State private var selectedTest: Test? = nil
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 25) {
//                // MARK: - Header
//                VStack(alignment: .leading) {
//                    Text("My Tests")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("View and manage all your tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Custom Tab View
//                // This custom implementation matches the styling of the original TypeScript version.
//                HStack {
//                    Spacer()
//                    HStack(spacing: 0) {
//                        ForEach(TestTab.allCases) { tab in
//                            TabButton(tab: tab, selectedTab: $selectedTab)
//                        }
//                    }
//                    .background(Color.quizifyPrimary.opacity(0.1))
//                    .cornerRadius(8)
//                    .frame(maxWidth: 600)
//                    Spacer()
//                }
//
//
//                // MARK: - Tests Grid
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 400), spacing: 25)], spacing: 25) {
//                    let tests = currentTests()
//                    if tests.isEmpty {
//                        // Placeholder for empty tabs, matching the original design.
//                        VStack(spacing: 10) {
//                            Image(systemName: "doc.text.magnifyingglass")
//                                .font(.largeTitle)
//                                .foregroundColor(.gray.opacity(0.5))
//                            Text("No tests in this category.")
//                                .foregroundColor(.gray)
//                                .font(.headline)
//                        }
//                        .frame(maxWidth: .infinity, minHeight: 200)
//                        .background(Color.gray.opacity(0.05))
//                        .cornerRadius(16)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
//                                .foregroundColor(.gray.opacity(0.2))
//                        )
//                    } else {
//                        ForEach(tests) { test in
//                            StudentTestCardView(test: test, onTakeTest: {
//                                selectedTest = test
//                            })
//                        }
//                    }
//                }
//            }
//            .padding(30)
//        }
//        .sheet(item: $selectedTest) { test in
//            // When a test is selected, the AttemptTestView is presented as a sheet.
//            AttemptTestView(testId: test.id)
//        }
//    }
//    
//    private func currentTests() -> [Test] {
//        switch selectedTab {
//        case .upcoming: return viewModel.upcomingTests
//        case .completed: return viewModel.completedTests
//        case .missed: return viewModel.missedTests
//        case .all: return viewModel.upcomingTests + viewModel.completedTests + viewModel.missedTests
//        }
//    }
//}
//
//// Enum for the test categories, now with associated colors for the tabs.
//enum TestTab: String, CaseIterable, Identifiable {
//    case upcoming = "Upcoming"
//    case completed = "Completed"
//    case missed = "Missed"
//    case all = "All Tests"
//    var id: String { self.rawValue }
//    
//    var activeColor: Color {
//        switch self {
//        case .upcoming: return .quizifyPrimary
//        case .completed: return .quizifyAccentGreen
//        case .missed: return .quizifyRedError
//        case .all: return .quizifyAccentBlue
//        }
//    }
//}
//
//// MARK: - TabButton
//// A dedicated view for the custom tab buttons to keep the main view clean.
//struct TabButton: View {
//    let tab: TestTab
//    @Binding var selectedTab: TestTab
//    
//    var body: some View {
//        Button(action: {
//            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
//                selectedTab = tab
//            }
//        }) {
//            Text(tab.rawValue)
//                .font(.headline)
//                .fontWeight(.semibold)
//                .padding(.vertical, 12)
//                .frame(maxWidth: .infinity)
//                .background(
//                    ZStack {
//                        if selectedTab == tab {
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(tab.activeColor)
//                                .shadow(radius: 3, y: 2)
//                        }
//                    }
//                )
//                .foregroundColor(selectedTab == tab ? .white : .primary)
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//
//// MARK: - StudentTestCardView
//// A card displaying a summary of a student's test, redesigned to be more professional and visually appealing.
//struct StudentTestCardView: View {
//    let test: Test
//    var onTakeTest: () -> Void
//    
//    private var statusColor: Color {
//        switch test.status {
//        case "Upcoming": return .quizifyAccentYellow
//        case "Completed": return .quizifyAccentGreen
//        case "Missed": return .quizifyRedError
//        default: return .gray
//        }
//    }
//    
//    private var buttonColor: Color {
//        test.status == "Upcoming" ? .quizifyPrimary : .quizifyAccentBlue
//    }
//    
//    private var buttonText: String {
//        switch test.status {
//        case "Upcoming": return "Take Test"
//        case "Completed": return "View Results"
//        default: return "Missed"
//        }
//    }
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            // Top section with title and teacher info
//            VStack(alignment: .leading, spacing: 12) {
//                VStack(alignment: .leading) {
//                    Text(test.title).font(.system(size: 22, weight: .bold)).lineLimit(1)
//                    Text(test.subject).font(.system(size: 17)).foregroundColor(.gray)
//                }
//                
//                HStack {
//                    AsyncImage(url: URL(string: test.teacherAvatar ?? "")) { phase in
//                        if let image = phase.image {
//                            image.resizable().clipShape(Circle())
//                        } else {
//                            Image(systemName: "person.crop.circle.fill").resizable()
//                        }
//                    }
//                    .frame(width: 30, height: 30)
//                    Text(test.teacher).font(.headline).foregroundColor(.quizifyTextGray)
//                }
//            }
//            
//            Spacer()
//            
//            // Middle section with test details grid, now in a styled container.
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
//                TestCardInfoRow(icon: "book.closed.fill", text: test.className, color: .quizifyPrimary)
//                TestCardInfoRow(icon: "hourglass", text: test.duration, color: .quizifyAccentYellow)
//                TestCardInfoRow(icon: "calendar", text: test.date, color: .quizifyAccentBlue)
//                TestCardInfoRow(icon: "clock.fill", text: test.time, color: .quizifyAccentGreen)
//            }
//            .padding()
//            .background(Color.gray.opacity(0.05))
//            .cornerRadius(12)
//            
//            Spacer()
//            
//            // Bottom section with status badges and action button
//            VStack(spacing: 15) {
//                HStack {
//                    TestCardBadge(text: test.status, color: statusColor)
//                    if let score = test.score {
//                        TestCardBadge(text: "Score: \(score)%", color: .quizifyAccentBlue)
//                    }
//                    Spacer()
//                }
//                
//                Button(action: onTakeTest) {
//                    Label(buttonText, systemImage: "eye.fill")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 10)
//                }
//                .buttonStyle(OutlineButtonStyle(color: buttonColor))
//                .disabled(test.status == "Missed")
//            }
//        }
//        .padding(25)
//        .frame(minHeight: 340)
//        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// MARK: - Helper Views
//// Renamed to avoid conflicts with other views.
//fileprivate struct TestCardInfoRow: View {
//    let icon: String
//    let text: String
//    let color: Color
//
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .font(.headline)
//                .foregroundColor(color)
//                .frame(width: 20)
//            Text(text)
//                .font(.headline)
//                .fontWeight(.medium)
//                .foregroundColor(.quizifyTextGray)
//            Spacer()
//        }
//    }
//}
//
//fileprivate struct TestCardBadge: View {
//    let text: String
//    let color: Color
//    
//    var body: some View {
//        Text(text)
//            .font(.subheadline)
//            .fontWeight(.medium)
//            .padding(.horizontal, 12)
//            .padding(.vertical, 5)
//            .background(color.opacity(0.15))
//            .foregroundColor(color)
//            .cornerRadius(15)
//    }
//}


//Now we're talking !!!

//import SwiftUI
//
//// The TestsView allows a student to see all their assigned tests,
//// categorized by status. It serves as the main hub for test management.
//struct TestsView: View {
//    @StateObject private var viewModel = StudentTestsViewModel()
//    @State private var selectedTab: TestTab = .upcoming
//    @State private var selectedTest: Test? = nil
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 25) {
//                // MARK: - Header
//                VStack(alignment: .leading) {
//                    Text("My Tests")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("View and manage all your tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Custom Tab View
//                // This custom implementation matches the styling of the original TypeScript version.
//                HStack {
//                    Spacer()
//                    HStack(spacing: 0) {
//                        ForEach(TestTab.allCases) { tab in
//                            TabButton(tab: tab, selectedTab: $selectedTab)
//                        }
//                    }
//                    .background(Color.quizifyPrimary.opacity(0.1))
//                    .cornerRadius(8)
//                    .frame(maxWidth: 600)
//                    Spacer()
//                }
//
//
//                // MARK: - Tests Grid
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 400), spacing: 25)], spacing: 25) {
//                    let tests = currentTests()
//                    if tests.isEmpty {
//                        // Placeholder for empty tabs, matching the original design.
//                        VStack(spacing: 10) {
//                            Image(systemName: "doc.text.magnifyingglass")
//                                .font(.largeTitle)
//                                .foregroundColor(.gray.opacity(0.5))
//                            Text("No tests in this category.")
//                                .foregroundColor(.gray)
//                                .font(.headline)
//                        }
//                        .frame(maxWidth: .infinity, minHeight: 200)
//                        .background(Color.gray.opacity(0.05))
//                        .cornerRadius(16)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 16)
//                                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
//                                .foregroundColor(.gray.opacity(0.2))
//                        )
//                    } else {
//                        ForEach(tests) { test in
//                            StudentTestCardView(test: test, onTakeTest: {
//                                selectedTest = test
//                            })
//                        }
//                    }
//                }
//            }
//            .padding(30)
//        }
//        .sheet(item: $selectedTest) { test in
//            // When a test is selected, the AttemptTestView is presented as a sheet.
//            AttemptTestView(testId: test.id)
//        }
//    }
//    
//    private func currentTests() -> [Test] {
//        switch selectedTab {
//        case .upcoming: return viewModel.upcomingTests
//        case .completed: return viewModel.completedTests
//        case .missed: return viewModel.missedTests
//        case .all: return viewModel.upcomingTests + viewModel.completedTests + viewModel.missedTests
//        }
//    }
//}
//
//// Enum for the test categories, now with associated colors for the tabs.
//enum TestTab: String, CaseIterable, Identifiable {
//    case upcoming = "Upcoming"
//    case completed = "Completed"
//    case missed = "Missed"
//    case all = "All Tests"
//    var id: String { self.rawValue }
//    
//    var activeColor: Color {
//        switch self {
//        case .upcoming: return .quizifyPrimary
//        case .completed: return .quizifyAccentGreen
//        case .missed: return .quizifyRedError
//        case .all: return .quizifyAccentBlue
//        }
//    }
//}
//
//// MARK: - TabButton
//// A dedicated view for the custom tab buttons to keep the main view clean.
//struct TabButton: View {
//    let tab: TestTab
//    @Binding var selectedTab: TestTab
//    
//    var body: some View {
//        Button(action: {
//            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
//                selectedTab = tab
//            }
//        }) {
//            Text(tab.rawValue)
//                .font(.headline)
//                .fontWeight(.semibold)
//                .padding(.vertical, 12)
//                .frame(maxWidth: .infinity)
//                .background(
//                    ZStack {
//                        if selectedTab == tab {
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(tab.activeColor)
//                                .shadow(radius: 3, y: 2)
//                        }
//                    }
//                )
//                .foregroundColor(selectedTab == tab ? .white : .primary)
//        }
//        .buttonStyle(PlainButtonStyle())
//    }
//}
//
//
//// MARK: - StudentTestCardView
//// A card displaying a summary of a student's test, redesigned to be more professional and visually appealing.
//struct StudentTestCardView: View {
//    let test: Test
//    var onTakeTest: () -> Void
//    
//    private var statusColor: Color {
//        switch test.status {
//        case "Upcoming": return .quizifyAccentYellow
//        case "Completed": return .quizifyAccentGreen
//        case "Missed": return .quizifyRedError
//        default: return .gray
//        }
//    }
//    
//    private var buttonColor: Color {
//        test.status == "Upcoming" ? .quizifyPrimary : .quizifyAccentBlue
//    }
//    
//    private var buttonText: String {
//        switch test.status {
//        case "Upcoming": return "Take Test"
//        case "Completed": return "View Results"
//        default: return "Missed"
//        }
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            // Top section with title and teacher info
//            VStack(alignment: .leading, spacing: 12) {
//                VStack(alignment: .leading) {
//                    Text(test.title).font(.system(size: 22, weight: .bold)).lineLimit(1)
//                    Text(test.subject).font(.system(size: 17)).foregroundColor(.gray)
//                }
//                
//                HStack {
//                    AsyncImage(url: URL(string: test.teacherAvatar ?? "")) { phase in
//                        if let image = phase.image {
//                            image.resizable().clipShape(Circle())
//                        } else {
//                            Image(systemName: "person.crop.circle.fill").resizable()
//                        }
//                    }
//                    .frame(width: 30, height: 30)
//                    Text(test.teacher).font(.headline).foregroundColor(.quizifyTextGray)
//                }
//            }
//            
//            // Middle section with the new "+" cross layout
//            TestDetailsCrossLayout(test: test)
//            
//            // Bottom section with status badges and action button
//            VStack(spacing: 15) {
//                HStack {
//                    TestCardBadge(text: test.status, color: statusColor)
//                    if let score = test.score {
//                        TestCardBadge(text: "Score: \(score)%", color: .quizifyAccentBlue)
//                    }
//                    Spacer()
//                }
//                
//                Button(action: onTakeTest) {
//                    Label(buttonText, systemImage: "eye.fill")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 10)
//                }
//                .buttonStyle(OutlineButtonStyle(color: buttonColor))
//                .disabled(test.status == "Missed")
//            }
//        }
//        .padding(25)
//        .frame(minHeight: 340)
//        .background(Color.white)
//        .cornerRadius(20)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// MARK: - Helper Views
//// A new helper view for the creative cross layout.
//fileprivate struct TestDetailsCrossLayout: View {
//    let test: Test
//
//    var body: some View {
//        ZStack {
//            // Vertical divider line with a subtle shadow for depth.
//            Rectangle()
//                .fill(Color.gray.opacity(0.15))
//                .frame(width: 1)
//                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
//
//            // Horizontal divider line with a subtle shadow.
//            Rectangle()
//                .fill(Color.gray.opacity(0.15))
//                .frame(height: 1)
//                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
//
//            // Arrange the four info rows in a 2x2 grid structure
//            // that visually appears to be around the cross.
//            VStack(spacing: 20) {
//                HStack(spacing: 20) {
//                    TestCardInfoRow(icon: "book.closed.fill", text: test.className, color: .quizifyPrimary)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    TestCardInfoRow(icon: "hourglass", text: test.duration, color: .quizifyAccentYellow)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                HStack(spacing: 20) {
//                    TestCardInfoRow(icon: "calendar", text: test.date, color: .quizifyAccentBlue)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    TestCardInfoRow(icon: "clock.fill", text: test.time, color: .quizifyAccentGreen)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                }
//            }
//        }
//        .padding()
//        .background(Color.gray.opacity(0.05))
//        .cornerRadius(12)
//    }
//}
//
//// Renamed to avoid conflicts with other views.
//fileprivate struct TestCardInfoRow: View {
//    let icon: String
//    let text: String
//    let color: Color
//
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .font(.headline)
//                .foregroundColor(color)
//                .frame(width: 20)
//            Text(text)
//                .font(.headline)
//                .fontWeight(.medium)
//                .foregroundColor(.quizifyTextGray)
//            Spacer()
//        }
//    }
//}
//
//fileprivate struct TestCardBadge: View {
//    let text: String
//    let color: Color
//    
//    var body: some View {
//        Text(text)
//            .font(.subheadline)
//            .fontWeight(.medium)
//            .padding(.horizontal, 12)
//            .padding(.vertical, 5)
//            .background(color.opacity(0.15))
//            .foregroundColor(color)
//            .cornerRadius(15)
//    }
//}






import SwiftUI

// The TestsView allows a student to see all their assigned tests,
// categorized by status. It serves as the main hub for test management.
struct TestsView: View {
    @StateObject private var viewModel = StudentTestsViewModel()
    @State private var selectedTab: TestTab = .upcoming
    @State private var testToConfirm: Test? = nil
    @State private var isTestActive = false

    var body: some View {
        ZStack {
            // Main content of the page, using the exact layout you provided.
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    // MARK: - Header
                    VStack(alignment: .leading) {
                        Text("My Tests")
                            .font(.system(size: 28, weight: .bold))
                        Text("View and manage all your tests.")
                            .font(.title3)
                            .foregroundColor(.quizifyTextGray)
                    }

                    // MARK: - Custom Tab View
                    HStack {
                        Spacer()
                        HStack(spacing: 0) {
                            ForEach(TestTab.allCases) { tab in
                                TabButton(tab: tab, selectedTab: $selectedTab)
                            }
                        }
                        .background(Color.quizifyPrimary.opacity(0.1))
                        .cornerRadius(8)
                        .frame(maxWidth: 600)
                        Spacer()
                    }

                    // MARK: - Tests Grid
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 400), spacing: 25)], spacing: 25) {
                        let tests = currentTests()
                        if tests.isEmpty {
                            // Placeholder for empty tabs
                            VStack(spacing: 10) {
                                Image(systemName: "doc.text.magnifyingglass")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("No tests in this category.")
                                    .foregroundColor(.gray)
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .background(Color.gray.opacity(0.05))
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                    .foregroundColor(.gray.opacity(0.2))
                            )
                        } else {
                            ForEach(tests) { test in
                                StudentTestCardView(test: test, onTakeTest: {
                                    testToConfirm = test
                                })
                            }
                        }
                    }
                }
                .padding(30)
            }
            
            // MARK: - Confirmation Dialog & Full Screen Test View
            // This logic is added on top of your provided code to handle the new test-taking flow.
            if let test = testToConfirm {
                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                
                StartTestConfirmationView(
                    test: test,
                    onStart: {
                        isTestActive = true
                    },
                    onCancel: { testToConfirm = nil }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            if isTestActive, let test = testToConfirm {
                AttemptTestView(testId: test.id, onFinish: {
                    isTestActive = false
                    testToConfirm = nil
                })
                .transition(.scale)
            }
        }
        .animation(.spring(), value: testToConfirm)
        .animation(.spring(), value: isTestActive)
    }
    
    // Corrected to return [StudentTest] to match the ViewModel
    private func currentTests() -> [Test] {
        switch selectedTab {
        case .upcoming: return viewModel.upcomingTests
        case .completed: return viewModel.completedTests
        case .missed: return viewModel.missedTests
        case .all: return viewModel.upcomingTests + viewModel.completedTests + viewModel.missedTests
        }
    }
}

// Enum for the test categories, now with associated colors for the tabs.
enum TestTab: String, CaseIterable, Identifiable {
    case upcoming = "Upcoming"
    case completed = "Completed"
    case missed = "Missed"
    case all = "All Tests"
    var id: String { self.rawValue }
    
    var activeColor: Color {
        switch self {
        case .upcoming: return .quizifyPrimary
        case .completed: return .quizifyAccentGreen
        case .missed: return .quizifyRedError
        case .all: return .quizifyAccentBlue
        }
    }
}

// MARK: - TabButton
// A dedicated view for the custom tab buttons to keep the main view clean.
struct TabButton: View {
    let tab: TestTab
    @Binding var selectedTab: TestTab
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        }) {
            Text(tab.rawValue)
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        if selectedTab == tab {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(tab.activeColor)
                                .shadow(radius: 3, y: 2)
                        }
                    }
                )
                .foregroundColor(selectedTab == tab ? .white : .primary)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


// MARK: - StudentTestCardView
// A card displaying a summary of a student's test, redesigned to be more professional and visually appealing.
struct StudentTestCardView: View {
    let test: Test // Corrected type
    var onTakeTest: () -> Void
    
    private var statusColor: Color {
        switch test.status {
        case "Upcoming": return .orange
        case "Completed": return .quizifyAccentGreen
        case "Missed": return .quizifyRedError
        default: return .gray
        }
    }
    
    private var buttonColor: Color {
        test.status == "Upcoming" ? .quizifyPrimary : .quizifyAccentBlue
    }
    
    private var buttonText: String {
        switch test.status {
        case "Upcoming": return "Take Test"
        case "Completed": return "View Results"
        default: return "Missed"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Top section with title and teacher info
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading) {
                    Text(test.title).font(.system(size: 22, weight: .bold)).lineLimit(1)
                    Text(test.subject).font(.system(size: 17)).foregroundColor(.gray)
                }
                
                HStack {
                    AsyncImage(url: URL(string: test.teacherAvatar ?? "")) { phase in
                        if let image = phase.image {
                            image.resizable().clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle.fill").resizable()
                        }
                    }
                    .frame(width: 30, height: 30)
                    Text(test.teacher).font(.headline).foregroundColor(.quizifyTextGray)
                }
            }
            
            // Middle section with the new "+" cross layout
            TestDetailsCrossLayout(test: test)
            
            // Bottom section with status badges and action button
            VStack(spacing: 15) {
                HStack {
                    TestCardBadge(text: test.status, color: statusColor)
                    if let score = test.score {
                        TestCardBadge(text: "Score: \(score)%", color: .quizifyAccentBlue)
                    }
                    Spacer()
                }
                
                Button(action: onTakeTest) {
                    Label(buttonText, systemImage: "eye.fill")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                }
                .buttonStyle(OutlineButtonStyle(color: buttonColor))
                .disabled(test.status == "Missed")
            }
        }
        .padding(25)
        .frame(minHeight: 340)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Helper Views
// A new helper view for the creative cross layout.
fileprivate struct TestDetailsCrossLayout: View {
    let test: Test // Corrected type

    var body: some View {
        ZStack {
            // Vertical divider line with a subtle shadow for depth.
            Rectangle()
                .fill(Color.gray.opacity(0.15))
                .frame(width: 1)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)

            // Horizontal divider line with a subtle shadow.
            Rectangle()
                .fill(Color.gray.opacity(0.15))
                .frame(height: 1)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)

            // Arrange the four info rows in a 2x2 grid structure
            // that visually appears to be around the cross.
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    TestCardInfoRow(icon: "book.closed.fill", text: test.className, color: .quizifyPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TestCardInfoRow(icon: "hourglass", text: test.duration, color: .quizifyAccentYellow)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack(spacing: 20) {
                    TestCardInfoRow(icon: "calendar", text: test.date, color: .quizifyAccentBlue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TestCardInfoRow(icon: "clock.fill", text: test.time, color: .quizifyAccentGreen)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

fileprivate struct TestCardInfoRow: View {
    let icon: String
    let text: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.headline)
                .foregroundColor(color)
                .frame(width: 20)
            Text(text)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.quizifyTextGray)
            Spacer()
        }
    }
}

fileprivate struct TestCardBadge: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.medium)
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .cornerRadius(15)
    }
}
