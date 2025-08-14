//
//  DashboardView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

//import SwiftUI
//
//// The DashboardView is the central hub of the application, providing an at-a-glance
//// overview of the student's status, recent activities, and upcoming tests.
//struct DashboardView: View {
//    // The ViewModel provides the data for this view.
//    @StateObject private var viewModel = DashboardViewModel()
//
//    var body: some View {
//        // GeometryReader is used to create responsive layouts that adapt to the available space.
//        GeometryReader { geometry in
//            ScrollView {
//                VStack(alignment: .leading, spacing: 30) {
//                    // MARK: - Welcome Header
//                    VStack(alignment: .leading) {
//                        Text("Welcome back, John!")
//                            .font(.system(size: 28, weight: .bold))
//                        Text("Here's a summary of your academic progress.")
//                            .font(.title3)
//                            .foregroundColor(.quizifyTextGray)
//                    }
//
//                    // MARK: - Stat Cards
//                    // A grid of StatCardViews to display key metrics.
//                    // The grid is adaptive, meaning it will adjust the number of columns based on the available width.
//                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 30)], spacing: 30) {
//                        StatCardView(title: "Active Classes", value: "5", description: "You are currently enrolled in 5 classes.", icon: "books.vertical.fill", trend: "+1 this semester", color: .quizifyPrimary)
//                        StatCardView(title: "Upcoming Tests", value: "3", description: "You have 3 tests in the next 7 days.", icon: "pencil.and.ruler.fill", trend: "1 due tomorrow", color: .quizifyAccentBlue)
//                        StatCardView(title: "Average Score", value: "87%", description: "Your average score across all tests.", icon: "chart.bar.xaxis", trend: "+2% from last month", color: .quizifyAccentGreen)
//                    }
//
//                    // MARK: - Main Content Area (Recent Activity & Upcoming Tests)
//                    // The main content is split into two columns for a clean desktop layout.
//                    HStack(alignment: .top, spacing: 30) {
//                        // Left Column: Recent Activity
//                        ActivitySectionView(activities: viewModel.activities)
//                            .frame(width: (geometry.size.width - 90) / 2) // 90 = padding + spacing
//
//                        // Right Column: Upcoming Tests & Class Progress
//                        VStack(spacing: 30) {
//                            UpcomingTestsSectionView(tests: viewModel.upcomingTests)
//                            ClassProgressSectionView(courses: viewModel.classProgress)
//                        }
//                        .frame(width: (geometry.size.width - 90) / 2)
//                    }
//                }
//                .padding(30)
//            }
//        }
//    }
//}
//
//// MARK: - ActivitySectionView
//// A dedicated view for the "Recent Activity" section.
//struct ActivitySectionView: View {
//    let activities: [Activity]
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Recent Activity")
//                .font(.title2)
//                .fontWeight(.bold)
//                .padding(.bottom, 10)
//            
//            VStack(spacing: 15) {
//                if activities.isEmpty {
//                    Text("No recent activity to display.")
//                        .foregroundColor(.gray)
//                        .padding()
//                } else {
//                    ForEach(activities) { activity in
//                        ActivityRow(activity: activity)
//                    }
//                }
//            }
//        }
//        .padding(20)
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// A single row in the activity list.
//struct ActivityRow: View {
//    let activity: Activity
//    
//    var body: some View {
//        HStack(spacing: 15) {
//            Image(systemName: activity.icon)
//                .font(.title2)
//                .frame(width: 50, height: 50)
//                .background(activity.color.opacity(0.15))
//                .foregroundColor(activity.color)
//                .cornerRadius(10)
//            
//            VStack(alignment: .leading, spacing: 2) {
//                Text(activity.title).fontWeight(.semibold)
//                Text(activity.description).font(.subheadline).foregroundColor(.quizifyTextGray)
//            }
//            Spacer()
//            Text(activity.time).font(.caption).foregroundColor(.quizifyTextGray)
//        }
//    }
//}
//
//// MARK: - UpcomingTestsSectionView
//// A dedicated view for the "Upcoming Tests" section.
//struct UpcomingTestsSectionView: View {
//    let tests: [Test]
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Upcoming Tests")
//                .font(.title2)
//                .fontWeight(.bold)
//                .padding(.bottom, 10)
//
//            VStack(spacing: 12) {
//                if tests.isEmpty {
//                    Text("No upcoming tests.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(tests) { test in
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text(test.title).fontWeight(.semibold)
//                                Text(test.className).font(.subheadline).foregroundColor(.gray)
//                            }
//                            Spacer()
//                            VStack(alignment: .trailing) {
//                                Text(test.date).fontWeight(.semibold)
//                                Text(test.time).font(.subheadline).foregroundColor(.gray)
//                            }
//                        }
//                        .padding(12)
//                        .background(Color.quizifyPrimary.opacity(0.05))
//                        .cornerRadius(10)
//                    }
//                }
//            }
//        }
//        .padding(20)
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// MARK: - ClassProgressSectionView
//// A dedicated view for the "Class Progress" section.
//struct ClassProgressSectionView: View {
//    let courses: [Course]
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Class Progress")
//                .font(.title2)
//                .fontWeight(.bold)
//                .padding(.bottom, 10)
//            
//            VStack(spacing: 12) {
//                if courses.isEmpty {
//                    Text("No active classes to show progress for.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(courses) { course in
//                        VStack(alignment: .leading, spacing: 5) {
//                            HStack {
//                                Text(course.name).fontWeight(.semibold)
//                                Spacer()
//                                Text("\(course.progress)%").fontWeight(.semibold)
//                            }
//                            ProgressView(value: Double(course.progress), total: 100)
//                                .progressViewStyle(LinearProgressViewStyle(tint: course.themeColor))
//                        }
//                        .padding(12)
//                        .background(Color.white)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color.quizifyLightGray, lineWidth: 1)
//                        )
//                        .cornerRadius(10)
//                    }
//                }
//            }
//        }
//        .padding(20)
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// MARK: - Preview
//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//    }
//}






//

//import SwiftUI
//
//// The DashboardView is the central hub of the application, providing an at-a-glance
//// overview of the student's status, recent activities, and upcoming tests.
//struct DashboardView: View {
//    // The ViewModel provides the data for this view.
//    @StateObject private var viewModel = DashboardViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 30) {
//                // MARK: - Welcome Header
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("STUDENT DASHBOARD")
//                        .font(.caption)
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 5)
//                        .background(Color.quizifyAccentYellow)
//                        .foregroundColor(Color.quizifyDarkBackground)
//                        .cornerRadius(15)
//
//                    Text("Welcome back, John!")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("Here's what's happening with your classes and tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Stats Overview
//                // An adaptive grid for the stat cards. This will automatically adjust the number of
//                // columns based on the available width, ensuring it looks good on any screen size.
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 30)], spacing: 30) {
//                    StatCardView(title: "Classes", value: "5", description: "Active classes", icon: "books.vertical.fill", trend: "+1 this week", color: .quizifyPrimary)
//                    StatCardView(title: "Tests", value: "12", description: "Upcoming tests", icon: "pencil.and.ruler.fill", trend: "3 due soon", color: .quizifyAccentBlue)
//                    StatCardView(title: "Results", value: "87%", description: "Average score", icon: "chart.bar.xaxis", trend: "+2% from last month", color: .quizifyAccentGreen)
//                    StatCardView(title: "Completion", value: "92%", description: "Course progress", icon: "hourglass", trend: "On track for completion", color: .quizifyAccentYellow)
//                }
//
//                // MARK: - Main Content Grid
//                // A two-column grid for the main content sections, mimicking the React version's layout.
//                LazyVGrid(columns: [GridItem(.flexible(minimum: 400)), GridItem(.flexible(minimum: 400))], spacing: 30) {
//                    ActivitySectionView(activities: viewModel.activities)
//                    UpcomingTestsSectionView(tests: viewModel.upcomingTests)
//                }
//
//                // MARK: - Class Progress Section
//                // This section appears below the two-column grid, as in the original design.
//                ClassProgressSectionView(courses: viewModel.classProgress)
//            }
//            .padding(30)
//        }
//    }
//}
//
//// MARK: - ActivitySectionView
//struct ActivitySectionView: View {
//    let activities: [Activity]
//    
//    var body: some View {
//        TitledSection(title: "Recent Activity", description: "Your latest quiz results and class activities.") {
//            VStack(spacing: 15) {
//                if activities.isEmpty {
//                    Text("No recent activity to display.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(activities) { activity in
//                        ActivityRow(activity: activity)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - UpcomingTestsSectionView
//struct UpcomingTestsSectionView: View {
//    let tests: [Test]
//
//    var body: some View {
//        TitledSection(title: "Upcoming Tests", description: "Tests scheduled in the next 7 days.") {
//            VStack(spacing: 12) {
//                if tests.isEmpty {
//                    Text("No upcoming tests.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(tests) { test in
//                        UpcomingTestRow(test: test)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - ClassProgressSectionView
//struct ClassProgressSectionView: View {
//    let courses: [Course]
//    
//    var body: some View {
//        TitledSection(title: "Class Progress", description: "An overview of your progress in active classes.") {
//            // A two-column grid for the progress bars.
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                if courses.isEmpty {
//                    Text("No active classes to show progress for.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(courses) { course in
//                        ClassProgressRow(course: course)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Reusable Row and Section Components
//struct ActivityRow: View {
//    let activity: Activity
//    var body: some View {
//        HStack(spacing: 15) {
//            Image(systemName: activity.icon)
//                .font(.title2)
//                .frame(width: 50, height: 50)
//                .background(activity.color.opacity(0.15))
//                .foregroundColor(activity.color)
//                .cornerRadius(10)
//            VStack(alignment: .leading, spacing: 2) {
//                Text(activity.title).fontWeight(.semibold)
//                Text(activity.description).font(.subheadline).foregroundColor(.quizifyTextGray)
//            }
//            Spacer()
//            Text(activity.time).font(.caption).foregroundColor(.quizifyTextGray)
//        }
//    }
//}
//
//struct UpcomingTestRow: View {
//    let test: Test
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(test.title).fontWeight(.semibold)
//                Text(test.className).font(.subheadline).foregroundColor(.gray)
//            }
//            Spacer()
//            VStack(alignment: .trailing) {
//                Text(test.date).fontWeight(.semibold)
//                Text(test.time).font(.subheadline).foregroundColor(.gray)
//            }
//        }
//        .padding(12)
//        .background(Color.quizifyPrimary.opacity(0.05))
//        .cornerRadius(10)
//    }
//}
//
//struct ClassProgressRow: View {
//    let course: Course
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text(course.name).fontWeight(.semibold)
//            ProgressView(value: Double(course.progress), total: 100)
//                .progressViewStyle(LinearProgressViewStyle(tint: course.themeColor))
//            HStack {
//                Text("\(course.testsCompleted)/\(course.totalTests) tests")
//                Spacer()
//                Text("\(course.progress)%")
//            }
//            .font(.caption)
//            .foregroundColor(.quizifyTextGray)
//        }
//        .padding(15)
//        .background(Color.white)
//        .cornerRadius(12)
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyLightGray.opacity(0.5)))
//    }
//}
//
//// MARK: - Preview
//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//    }
//}







//
//import SwiftUI
//
//// The DashboardView is the central hub of the application, providing an at-a-glance
//// overview of the student's status, recent activities, and upcoming tests.
//struct DashboardView: View {
//    // The ViewModel provides the data for this view.
//    @StateObject private var viewModel = DashboardViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 30) {
//                // MARK: - Welcome Header
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("STUDENT DASHBOARD")
//                        .font(.caption)
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 5)
//                        .background(Color.quizifyAccentYellow)
//                        .foregroundColor(Color.quizifyDarkBackground)
//                        .cornerRadius(15)
//
//                    Text("Welcome back, John!")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("Here's what's happening with your classes and tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Stats Overview
//                // An adaptive grid for the stat cards. This now includes a fifth card
//                // to create a more balanced and complete horizontal layout on wide screens.
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 260), spacing: 30)], spacing: 30) {
//                    StatCardView(title: "Classes", value: "5", description: "Active classes", icon: "books.vertical.fill", trend: "+1 this week", color: .quizifyPrimary)
//                    StatCardView(title: "Tests", value: "12", description: "Upcoming tests", icon: "pencil.and.ruler.fill", trend: "3 due soon", color: .quizifyAccentBlue)
//                    StatCardView(title: "Results", value: "87%", description: "Average score", icon: "chart.bar.xaxis", trend: "+2% from last month", color: .quizifyAccentGreen)
//                    StatCardView(title: "Completion", value: "92%", description: "Course progress", icon: "hourglass", trend: "On track for completion", color: .quizifyAccentYellow)
//                    StatCardView(title: "Study Streak", value: "14", description: "Days of consistent study", icon: "flame.fill", trend: "Keep it up!", color: .orange)
////                    StatCardView(title: "Study Streak", value: "14", description: "Days of consistent study", icon: "flame.fill", trend: "Keep it up!", color: .orange)
//                }
//
//                // MARK: - Main Content Grid
//                // A two-column grid for the main content sections, mimicking the React version's layout.
//                LazyVGrid(columns: [GridItem(.flexible(minimum: 400)), GridItem(.flexible(minimum: 400))], spacing: 30) {
//                    ActivitySectionView(activities: viewModel.activities)
//                    UpcomingTestsSectionView(tests: viewModel.upcomingTests)
//                }
//
//                // MARK: - Class Progress Section
//                // This section appears below the two-column grid, as in the original design.
//                ClassProgressSectionView(courses: viewModel.classProgress)
//            }
//            .padding(30)
//        }
//    }
//}
//
//// MARK: - ActivitySectionView
//struct ActivitySectionView: View {
//    let activities: [Activity]
//    
//    var body: some View {
//        TitledSection(title: "Recent Activity", description: "Your latest quiz results and class activities.") {
//            VStack(spacing: 15) {
//                if activities.isEmpty {
//                    Text("No recent activity to display.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(activities) { activity in
//                        ActivityRow(activity: activity)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - UpcomingTestsSectionView
//struct UpcomingTestsSectionView: View {
//    let tests: [Test]
//
//    var body: some View {
//        TitledSection(title: "Upcoming Tests", description: "Tests scheduled in the next 7 days.") {
//            VStack(spacing: 12) {
//                if tests.isEmpty {
//                    Text("No upcoming tests.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(tests) { test in
//                        UpcomingTestRow(test: test)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - ClassProgressSectionView
//struct ClassProgressSectionView: View {
//    let courses: [Course]
//    
//    var body: some View {
//        TitledSection(title: "Class Progress", description: "An overview of your progress in active classes.") {
//            // A two-column grid for the progress bars.
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                if courses.isEmpty {
//                    Text("No active classes to show progress for.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(courses) { course in
//                        ClassProgressRow(course: course)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Reusable Row and Section Components
//struct ActivityRow: View {
//    let activity: Activity
//    var body: some View {
//        HStack(spacing: 15) {
//            Image(systemName: activity.icon)
//                .font(.title2)
//                .frame(width: 50, height: 50)
//                .background(activity.color.opacity(0.15))
//                .foregroundColor(activity.color)
//                .cornerRadius(10)
//            VStack(alignment: .leading, spacing: 2) {
//                Text(activity.title).fontWeight(.semibold)
//                Text(activity.description).font(.subheadline).foregroundColor(.quizifyTextGray)
//            }
//            Spacer()
//            Text(activity.time).font(.caption).foregroundColor(.quizifyTextGray)
//        }
//    }
//}
//
//struct UpcomingTestRow: View {
//    let test: Test
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(test.title).fontWeight(.semibold)
//                Text(test.className).font(.subheadline).foregroundColor(.gray)
//            }
//            Spacer()
//            VStack(alignment: .trailing) {
//                Text(test.date).fontWeight(.semibold)
//                Text(test.time).font(.subheadline).foregroundColor(.gray)
//            }
//        }
//        .padding(12)
//        .background(Color.quizifyPrimary.opacity(0.05))
//        .cornerRadius(10)
//    }
//}
//
//struct ClassProgressRow: View {
//    let course: Course
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text(course.name).fontWeight(.semibold)
//            ProgressView(value: Double(course.progress), total: 100)
//                .progressViewStyle(LinearProgressViewStyle(tint: course.themeColor))
//            HStack {
//                Text("\(course.testsCompleted)/\(course.totalTests) tests")
//                Spacer()
//                Text("\(course.progress)%")
//            }
//            .font(.caption)
//            .foregroundColor(.quizifyTextGray)
//        }
//        .padding(15)
//        .background(Color.white)
//        .cornerRadius(12)
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyLightGray.opacity(0.5)))
//    }
//}
//
//// MARK: - Preview
//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//    }
//}




//import SwiftUI
//
//// The DashboardView is the central hub of the application, providing an at-a-glance
//// overview of the student's status, recent activities, and upcoming tests.
//struct DashboardView: View {
//    // The ViewModel provides the data for this view.
//    @StateObject private var viewModel = DashboardViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 30) {
//                // MARK: - Welcome Header
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("STUDENT DASHBOARD")
//                        .font(.caption)
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 5)
//                        .background(Color.quizifyAccentYellow)
//                        .foregroundColor(Color.quizifyDarkBackground)
//                        .cornerRadius(15)
//
//                    Text("Welcome back, John!")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("Here's what's happening with your classes and tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Stats Overview
//                // A grid with 5 flexible columns to ensure the cards distribute evenly
//                // across the full width of the screen, resolving the layout gap.
//                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 25), count: 5), spacing: 25) {
//                    StatCardView(title: "Classes", value: "5", description: "Active classes", icon: "books.vertical.fill", trend: "+1 this week", color: .quizifyPrimary)
//                    StatCardView(title: "Tests", value: "12", description: "Upcoming tests", icon: "pencil.and.ruler.fill", trend: "3 due soon", color: .quizifyAccentBlue)
//                    StatCardView(title: "Results", value: "87%", description: "Average score", icon: "chart.bar.xaxis", trend: "+2% from last month", color: .quizifyAccentGreen)
//                    StatCardView(title: "Completion", value: "92%", description: "Course progress", icon: "hourglass", trend: "On track for completion", color: .quizifyAccentYellow)
//                    StatCardView(title: "Study Streak", value: "14", description: "Days of consistent study", icon: "flame.fill", trend: "Keep it up!", color: .orange)
//                }
//
//                // MARK: - Main Content Grid
//                // A two-column grid for the main content sections, mimicking the React version's layout.
//                LazyVGrid(columns: [GridItem(.flexible(minimum: 400)), GridItem(.flexible(minimum: 400))], spacing: 30) {
//                    ActivitySectionView(activities: viewModel.activities)
//                    UpcomingTestsSectionView(tests: viewModel.upcomingTests)
//                }
//
//                // MARK: - Class Progress Section
//                // This section appears below the two-column grid, as in the original design.
//                ClassProgressSectionView(courses: viewModel.classProgress)
//            }
//            .padding(30)
//        }
//    }
//}
//
//// MARK: - ActivitySectionView
//struct ActivitySectionView: View {
//    let activities: [Activity]
//    
//    var body: some View {
//        TitledSection(title: "Recent Activity", description: "Your latest quiz results and class activities.") {
//            VStack(spacing: 15) {
//                if activities.isEmpty {
//                    Text("No recent activity to display.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(activities) { activity in
//                        ActivityRow(activity: activity)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - UpcomingTestsSectionView
//struct UpcomingTestsSectionView: View {
//    let tests: [Test]
//
//    var body: some View {
//        TitledSection(title: "Upcoming Tests", description: "Tests scheduled in the next 7 days.") {
//            VStack(spacing: 12) {
//                if tests.isEmpty {
//                    Text("No upcoming tests.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(tests) { test in
//                        UpcomingTestRow(test: test)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - ClassProgressSectionView
//struct ClassProgressSectionView: View {
//    let courses: [Course]
//    
//    var body: some View {
//        TitledSection(title: "Class Progress", description: "An overview of your progress in active classes.") {
//            // A two-column grid for the progress bars.
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                if courses.isEmpty {
//                    Text("No active classes to show progress for.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(courses) { course in
//                        ClassProgressRow(course: course)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Reusable Row and Section Components
//struct ActivityRow: View {
//    let activity: Activity
//    var body: some View {
//        HStack(spacing: 15) {
//            Image(systemName: activity.icon)
//                .font(.title2)
//                .frame(width: 50, height: 50)
//                .background(activity.color.opacity(0.15))
//                .foregroundColor(activity.color)
//                .cornerRadius(10)
//            VStack(alignment: .leading, spacing: 2) {
//                Text(activity.title).fontWeight(.semibold)
//                Text(activity.description).font(.subheadline).foregroundColor(.quizifyTextGray)
//            }
//            Spacer()
//            Text(activity.time).font(.caption).foregroundColor(.quizifyTextGray)
//        }
//    }
//}
//
//struct UpcomingTestRow: View {
//    let test: Test
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(test.title).fontWeight(.semibold)
//                Text(test.className).font(.subheadline).foregroundColor(.gray)
//            }
//            Spacer()
//            VStack(alignment: .trailing) {
//                Text(test.date).fontWeight(.semibold)
//                Text(test.time).font(.subheadline).foregroundColor(.gray)
//            }
//        }
//        .padding(12)
//        .background(Color.quizifyPrimary.opacity(0.05))
//        .cornerRadius(10)
//    }
//}
//
//struct ClassProgressRow: View {
//    let course: Course
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            Text(course.name).fontWeight(.semibold)
//            ProgressView(value: Double(course.progress), total: 100)
//                .progressViewStyle(LinearProgressViewStyle(tint: course.themeColor))
//            HStack {
//                Text("\(course.testsCompleted)/\(course.totalTests) tests")
//                Spacer()
//                Text("\(course.progress)%")
//            }
//            .font(.caption)
//            .foregroundColor(.quizifyTextGray)
//        }
//        .padding(15)
//        .background(Color.white)
//        .cornerRadius(12)
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyLightGray.opacity(0.5)))
//    }
//}
//
//// MARK: - Preview
//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//    }
//}




//import SwiftUI
//
//// The DashboardView is the central hub of the application, providing an at-a-glance
//// overview of the student's status, recent activities, and upcoming tests.
//struct DashboardView: View {
//    // The ViewModel provides the data for this view.
//    @StateObject private var viewModel = DashboardViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 30) {
//                // MARK: - Welcome Header
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("STUDENT DASHBOARD")
//                        .font(.caption)
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 5)
//                        .background(Color.quizifyAccentYellow)
//                        .foregroundColor(Color.quizifyDarkBackground)
//                        .cornerRadius(15)
//
//                    Text("Welcome back, John!")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("Here's what's happening with your classes and tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Stats Overview
//                // A grid with 5 flexible columns to ensure the cards distribute evenly
//                // across the full width of the screen, resolving the layout gap.
//                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 25), count: 5), spacing: 25) {
//                    StatCardView(title: "Classes", value: "5", description: "Active classes", icon: "books.vertical.fill", trend: "+1 this week", color: .quizifyPrimary)
//                    StatCardView(title: "Tests", value: "12", description: "Upcoming tests", icon: "pencil.and.ruler.fill", trend: "3 due soon", color: .quizifyAccentBlue)
//                    StatCardView(title: "Results", value: "87%", description: "Average score", icon: "chart.bar.xaxis", trend: "+2% from last month", color: .quizifyAccentGreen)
//                    StatCardView(title: "Completion", value: "92%", description: "Course progress", icon: "hourglass", trend: "On track for completion", color: .quizifyAccentYellow)
//                    StatCardView(title: "Study Streak", value: "14", description: "Days of consistent study", icon: "flame.fill", trend: "Keep it up!", color: .orange)
//                }
//
//                // MARK: - Main Content Grid
//                // A two-column grid for the main content sections, mimicking the React version's layout.
//                LazyVGrid(columns: [GridItem(.flexible(minimum: 400)), GridItem(.flexible(minimum: 400))], spacing: 30) {
//                    ActivitySectionView(activities: viewModel.activities)
//                    UpcomingTestsSectionView(tests: viewModel.upcomingTests)
//                }
//
//                // MARK: - Class Progress Section
//                // This section appears below the two-column grid, as in the original design.
//                ClassProgressSectionView(courses: viewModel.classProgress)
//            }
//            .padding(30)
//        }
//    }
//}
//
//// MARK: - ActivitySectionView
//struct ActivitySectionView: View {
//    let activities: [Activity]
//    
//    var body: some View {
//        TitledSection(
//            title: "Recent Activity",
//            description: "Your latest quiz results and class activities."
//        ) {
//            // Main content of the section
//            VStack(spacing: 15) {
//                if activities.isEmpty {
//                    Text("No recent activity to display.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(activities) { activity in
//                        ActivityRow(activity: activity)
//                    }
//                }
//            }
//        } footer: {
//            // Footer content with the "View All" button
//            Button(action: {}) {
//                Label("View All Activity", systemImage: "arrow.up.right")
//                    .frame(maxWidth: .infinity)
//            }
//            .buttonStyle(.bordered)
//            .tint(.quizifyPrimary)
//        }
//    }
//}
//
//// MARK: - UpcomingTestsSectionView
//struct UpcomingTestsSectionView: View {
//    let tests: [Test]
//
//    var body: some View {
//        TitledSection(
//            title: "Upcoming Tests",
//            description: "Tests scheduled in the next 7 days."
//        ) {
//            VStack(spacing: 12) {
//                if tests.isEmpty {
//                    Text("No upcoming tests.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(tests) { test in
//                        UpcomingTestRow(test: test)
//                    }
//                }
//            }
//        } footer: {
//            Button(action: {}) {
//                Label("View All Tests", systemImage: "arrow.up.right")
//                    .frame(maxWidth: .infinity)
//            }
//            .buttonStyle(.bordered)
//            .tint(.quizifyAccentBlue)
//        }
//    }
//}
//
//// MARK: - ClassProgressSectionView
//struct ClassProgressSectionView: View {
//    let courses: [Course]
//    
//    var body: some View {
//        TitledSection(title: "Class Progress", description: "An overview of your progress in active classes.") {
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                if courses.isEmpty {
//                    Text("No active classes to show progress for.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(courses) { course in
//                        ClassProgressRow(course: course)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Reusable Row and Section Components
//struct ActivityRow: View {
//    let activity: Activity
//    var body: some View {
//        HStack(spacing: 15) {
//            Image(systemName: activity.icon)
//                .font(.title2)
//                .frame(width: 50, height: 50)
//                .background(activity.color.opacity(0.15))
//                .foregroundColor(activity.color)
//                .cornerRadius(10)
//            VStack(alignment: .leading, spacing: 2) {
//                Text(activity.title).fontWeight(.semibold)
//                Text(activity.description).font(.subheadline).foregroundColor(.quizifyTextGray)
//            }
//            Spacer()
//            Text(activity.time).font(.caption).foregroundColor(.quizifyTextGray)
//        }
//    }
//}
//
//struct UpcomingTestRow: View {
//    let test: Test
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(test.title).fontWeight(.semibold)
//                    Text(test.className).font(.subheadline).foregroundColor(.gray)
//                }
//                Spacer()
//                VStack(alignment: .trailing) {
//                    Text(test.date).fontWeight(.semibold)
//                    Text(test.time).font(.subheadline).foregroundColor(.gray)
//                }
//            }
//            Button(action: {}) {
//                Label("View Details", systemImage: "arrow.up.right")
//                    .font(.caption)
//                    .frame(maxWidth: .infinity)
//            }
//            .buttonStyle(.bordered)
//            .tint(.quizifyPrimary)
//        }
//        .padding(12)
//        .background(Color.quizifyPrimary.opacity(0.05))
//        .cornerRadius(10)
//    }
//}
//
//struct ClassProgressRow: View {
//    let course: Course
//    
//    // Determines the color of the progress bar based on the progress value.
//    private var progressColor: Color {
//        if course.progress >= 75 { return .quizifyAccentGreen }
//        if course.progress >= 50 { return .quizifyAccentYellow }
//        return .quizifyRedError
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Text(course.name)
//                    .fontWeight(.bold)
//                Spacer()
//                Button(action: {}) {
//                    Label("Details", systemImage: "arrow.up.right")
//                }
//                .buttonStyle(.borderless)
//                .tint(.quizifyPrimary)
//                .font(.caption)
//            }
//            Text(course.teacher)
//                .font(.caption)
//                .foregroundColor(.quizifyTextGray)
//
//            ProgressView(value: Double(course.progress), total: 100)
//                .progressViewStyle(LinearProgressViewStyle(tint: progressColor))
//            
//            HStack {
//                Text("\(course.testsCompleted)/\(course.totalTests) tests")
//                Spacer()
//                Text("\(course.progress)%")
//            }
//            .font(.caption)
//            .foregroundColor(.quizifyTextGray)
//        }
//        .padding(15)
//        .background(Color.white)
//        .cornerRadius(12)
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyLightGray.opacity(0.5)))
//    }
//}
//
//// MARK: - Preview
//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//    }
//}


//import SwiftUI
//
//// The DashboardView is the central hub of the application, providing an at-a-glance
//// overview of the student's status, recent activities, and upcoming tests.
//struct DashboardView: View {
//    // The ViewModel provides the data for this view.
//    @StateObject private var viewModel = DashboardViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 30) {
//                // MARK: - Welcome Header
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("STUDENT DASHBOARD")
//                        .font(.caption)
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 5)
//                        .background(Color.quizifyAccentYellow)
//                        .foregroundColor(Color.quizifyDarkBackground)
//                        .cornerRadius(15)
//
//                    Text("Welcome back, John!")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("Here's what's happening with your classes and tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Stats Overview
//                // A grid with 5 flexible columns to ensure the cards distribute evenly
//                // across the full width of the screen, resolving the layout gap.
//                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 25), count: 5), spacing: 25) {
//                    StatCardView(title: "Classes", value: "5", description: "Active classes", icon: "books.vertical.fill", trend: "+1 this week", color: .quizifyPrimary)
//                    StatCardView(title: "Tests", value: "12", description: "Upcoming tests", icon: "pencil.and.ruler.fill", trend: "3 due soon", color: .quizifyAccentBlue)
//                    StatCardView(title: "Results", value: "87%", description: "Average score", icon: "chart.bar.xaxis", trend: "+2% from last month", color: .quizifyAccentGreen)
//                    StatCardView(title: "Completion", value: "92%", description: "Course progress", icon: "hourglass", trend: "On track for completion", color: .quizifyAccentYellow)
//                    StatCardView(title: "Study Streak", value: "14", description: "Days of consistent study", icon: "flame.fill", trend: "Keep it up!", color: .orange)
//                }
//
//                // MARK: - Main Content Grid
//                // A two-column grid for the main content sections, mimicking the React version's layout.
//                LazyVGrid(columns: [GridItem(.flexible(minimum: 400)), GridItem(.flexible(minimum: 400))], spacing: 30) {
//                    ActivitySectionView(activities: viewModel.activities)
//                    UpcomingTestsSectionView(tests: viewModel.upcomingTests)
//                }
//
//                // MARK: - Class Progress Section
//                // This section appears below the two-column grid, as in the original design.
//                ClassProgressSectionView(courses: viewModel.classProgress)
//            }
//            .padding(30)
//        }
//    }
//}
//
//// MARK: - ActivitySectionView
//struct ActivitySectionView: View {
//    let activities: [Activity]
//    
//    var body: some View {
//        TitledSection(
//            title: "Recent Activity",
//            description: "Your latest quiz results and class activities."
//        ) {
//            // Main content of the section
//            VStack(spacing: 15) {
//                if activities.isEmpty {
//                    Text("No recent activity to display.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(activities) { activity in
//                        ActivityRow(activity: activity)
//                    }
//                }
//            }
//        } footer: {
//            // Footer content with the "View All" button, styled to match the original design.
//            Button(action: {}) {
//                Label("View All Activity", systemImage: "arrow.up.right")
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 8)
//            }
//            .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//        }
//    }
//}
//
//// MARK: - UpcomingTestsSectionView
//struct UpcomingTestsSectionView: View {
//    let tests: [Test]
//
//    var body: some View {
//        TitledSection(
//            title: "Upcoming Tests",
//            description: "Tests scheduled in the next 7 days."
//        ) {
//            VStack(spacing: 12) {
//                if tests.isEmpty {
//                    Text("No upcoming tests.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(tests) { test in
//                        UpcomingTestRow(test: test)
//                    }
//                }
//            }
//        } footer: {
//            // Footer button styled to match the original design.
//            Button(action: {}) {
//                Label("View All Tests", systemImage: "arrow.up.right")
//                    .fontWeight(.semibold)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 8)
//            }
//            .buttonStyle(OutlineButtonStyle(color: .quizifyAccentBlue))
//        }
//    }
//}
//
//// MARK: - ClassProgressSectionView
//struct ClassProgressSectionView: View {
//    let courses: [Course]
//    
//    var body: some View {
//        TitledSection(title: "Class Progress", description: "An overview of your progress in active classes.") {
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                if courses.isEmpty {
//                    Text("No active classes to show progress for.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(courses) { course in
//                        ClassProgressRow(course: course)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Reusable Row and Section Components
//struct ActivityRow: View {
//    let activity: Activity
//    var body: some View {
//        HStack(spacing: 15) {
//            Image(systemName: activity.icon)
//                .font(.title2)
//                .frame(width: 50, height: 50)
//                .background(activity.color.opacity(0.15))
//                .foregroundColor(activity.color)
//                .cornerRadius(10)
//            VStack(alignment: .leading, spacing: 2) {
//                Text(activity.title).fontWeight(.semibold)
//                Text(activity.description).font(.subheadline).foregroundColor(.quizifyTextGray)
//            }
//            Spacer()
//            Text(activity.time).font(.caption).foregroundColor(.quizifyTextGray)
//        }
//    }
//}
//
//struct UpcomingTestRow: View {
//    let test: Test
//    var body: some View {
//        // Removed the "View Details" button and background color for a cleaner look.
//        HStack {
//            VStack(alignment: .leading) {
//                Text(test.title).fontWeight(.semibold)
//                Text(test.className).font(.subheadline).foregroundColor(.gray)
//            }
//            Spacer()
//            VStack(alignment: .trailing) {
//                Text(test.date).fontWeight(.semibold)
//                Text(test.time).font(.subheadline).foregroundColor(.gray)
//            }
//        }
//        .padding(12)
//        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.quizifyLightGray.opacity(0.5)))
//    }
//}
//
//struct ClassProgressRow: View {
//    let course: Course
//    
//    // Determines the color of the progress bar based on the progress value.
//    private var progressColor: Color {
//        if course.progress >= 75 { return .quizifyAccentGreen }
//        if course.progress >= 50 { return .quizifyAccentYellow }
//        return .quizifyRedError
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Text(course.name)
//                    .fontWeight(.bold)
//                Spacer()
//                // "Details" button styled to match the original design.
//                Button(action: {}) {
//                    Label("Details", systemImage: "arrow.up.right")
//                        .font(.caption)
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 4)
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//            }
//            Text(course.teacher)
//                .font(.caption)
//                .foregroundColor(.quizifyTextGray)
//
//            ProgressView(value: Double(course.progress), total: 100)
//                .progressViewStyle(LinearProgressViewStyle(tint: progressColor))
//            
//            HStack {
//                Text("\(course.testsCompleted)/\(course.totalTests) tests")
//                Spacer()
//                Text("\(course.progress)%")
//            }
//            .font(.caption)
//            .foregroundColor(.quizifyTextGray)
//        }
//        .padding(15)
//        .background(Color.white)
//        .cornerRadius(12)
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyLightGray.opacity(0.5)))
//    }
//}
//
//// A custom button style to replicate the outline effect from the original design.
//struct OutlineButtonStyle: ButtonStyle {
//    var color: Color
//
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .foregroundColor(color)
//            .background(Color.clear)
//            .cornerRadius(8)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(color, lineWidth: 1.5)
//            )
//            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
//            .opacity(configuration.isPressed ? 0.8 : 1.0)
//    }
//}
//
//// MARK: - Preview
//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//    }
//}



//import SwiftUI
//
//// The DashboardView is the central hub of the application, providing an at-a-glance
//// overview of the student's status, recent activities, and upcoming tests.
//struct DashboardView: View {
//    // The ViewModel provides the data for this view.
//    @StateObject private var viewModel = DashboardViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 30) {
//                // MARK: - Welcome Header
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("STUDENT DASHBOARD")
//                        .font(.caption)
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 5)
//                        .background(Color.quizifyAccentYellow)
//                        .foregroundColor(Color.quizifyDarkBackground)
//                        .cornerRadius(15)
//
//                    Text("Welcome back, John!")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("Here's what's happening with your classes and tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Stats Overview
//                // A grid with 5 flexible columns to ensure the cards distribute evenly
//                // across the full width of the screen, resolving the layout gap.
//                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 25), count: 5), spacing: 25) {
//                    StatCardView(title: "Classes", value: "5", description: "Active classes", icon: "books.vertical.fill", trend: "+1 this week", color: .quizifyPrimary)
//                    StatCardView(title: "Tests", value: "12", description: "Upcoming tests", icon: "pencil.and.ruler.fill", trend: "3 due soon", color: .quizifyAccentBlue)
//                    StatCardView(title: "Results", value: "87%", description: "Average score", icon: "chart.bar.xaxis", trend: "+2% from last month", color: .quizifyAccentGreen)
//                    StatCardView(title: "Completion", value: "92%", description: "Course progress", icon: "hourglass", trend: "On track for completion", color: .quizifyAccentYellow)
//                    StatCardView(title: "Study Streak", value: "14", description: "Days of consistent study", icon: "flame.fill", trend: "Keep it up!", color: .orange)
//                }
//
//                // MARK: - Main Content Grid
//                // A two-column grid for the main content sections, mimicking the React version's layout.
//                LazyVGrid(columns: [GridItem(.flexible(minimum: 400)), GridItem(.flexible(minimum: 400))], spacing: 30) {
//                    ActivitySectionView(activities: viewModel.activities)
//                    UpcomingTestsSectionView(tests: viewModel.upcomingTests)
//                }
//
//                // MARK: - Class Progress Section
//                // This section appears below the two-column grid, as in the original design.
//                ClassProgressSectionView(courses: viewModel.classProgress)
//            }
//            .padding(30)
//        }
//    }
//}
//
//// MARK: - ActivitySectionView
//struct ActivitySectionView: View {
//    let activities: [Activity]
//    
//    var body: some View {
//        TitledSection(
//            title: "Recent Activity",
//            description: "Your latest quiz results and class activities."
//        ) {
//            // Main content of the section
//            VStack(spacing: 15) {
//                if activities.isEmpty {
//                    Text("No recent activity to display.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(activities) { activity in
//                        ActivityRow(activity: activity)
//                    }
//                }
//            }
//        } footer: {
//            // Footer with a compact, centered button.
//            HStack {
//                Spacer()
//                Button(action: {}) {
//                    Label("View All Activity", systemImage: "arrow.up.right")
//                        .fontWeight(.semibold)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 8)
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//                Spacer()
//            }
//        }
//    }
//}
//
//// MARK: - UpcomingTestsSectionView
//struct UpcomingTestsSectionView: View {
//    let tests: [Test]
//
//    var body: some View {
//        TitledSection(
//            title: "Upcoming Tests",
//            description: "Tests scheduled in the next 7 days."
//        ) {
//            VStack(spacing: 12) {
//                if tests.isEmpty {
//                    Text("No upcoming tests.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(tests) { test in
//                        UpcomingTestRow(test: test)
//                    }
//                }
//            }
//        } footer: {
//            // Footer with a compact, centered button.
//            HStack {
//                Spacer()
//                Button(action: {}) {
//                    Label("View All Tests", systemImage: "arrow.up.right")
//                        .fontWeight(.semibold)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 8)
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyAccentBlue))
//                Spacer()
//            }
//        }
//    }
//}
//
//// MARK: - ClassProgressSectionView
//struct ClassProgressSectionView: View {
//    let courses: [Course]
//    
//    var body: some View {
//        TitledSection(title: "Class Progress", description: "An overview of your progress in active classes.") {
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                if courses.isEmpty {
//                    Text("No active classes to show progress for.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(courses) { course in
//                        ClassProgressRow(course: course)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Reusable Row and Section Components
//struct ActivityRow: View {
//    let activity: Activity
//    var body: some View {
//        HStack(spacing: 15) {
//            // Icon with a solid colored background and white foreground.
//            Image(systemName: activity.icon)
//                .font(.title2)
//                .foregroundColor(.white)
//                .frame(width: 50, height: 50)
//                .background(activity.color)
//                .cornerRadius(10)
//                
//            VStack(alignment: .leading, spacing: 2) {
//                Text(activity.title).fontWeight(.semibold)
//                Text(activity.description).font(.subheadline).foregroundColor(.quizifyTextGray)
//            }
//            Spacer()
//            // Timestamp with a clock icon.
//            Label(activity.time, systemImage: "clock")
//                .font(.caption)
//                .foregroundColor(.quizifyTextGray)
//        }
//        // Each activity item is now enclosed in a rounded container.
//        .padding(12)
//        .background(activity.color.opacity(0.05))
//        .cornerRadius(12)
//    }
//}
//
//struct UpcomingTestRow: View {
//    let test: Test
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(test.title).fontWeight(.semibold)
//                    Text(test.className).font(.subheadline).foregroundColor(.gray)
//                }
//                Spacer()
//                VStack(alignment: .trailing) {
//                    Text(test.date).fontWeight(.semibold)
//                    Text(test.time).font(.subheadline).foregroundColor(.gray)
//                }
//            }
//            // Re-added the "View Details" button, styled to match the original design.
//            Button(action: {}) {
//                Label("View Details", systemImage: "arrow.up.right")
//                    .font(.caption)
//                    .frame(maxWidth: .infinity)
//            }
//            .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//        }
//        .padding(12)
//        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.quizifyLightGray.opacity(0.5)))
//    }
//}
//
//struct ClassProgressRow: View {
//    let course: Course
//    
//    // Determines the color of the progress bar based on the progress value.
//    private var progressColor: Color {
//        if course.progress >= 75 { return .quizifyAccentGreen }
//        if course.progress >= 50 { return .quizifyAccentYellow }
//        return .quizifyRedError
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Text(course.name)
//                    .fontWeight(.bold)
//                Spacer()
//                // "Details" button styled to match the original design.
//                Button(action: {}) {
//                    Label("Details", systemImage: "arrow.up.right")
//                        .font(.caption)
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 4)
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//            }
//            Text(course.teacher)
//                .font(.caption)
//                .foregroundColor(.quizifyTextGray)
//
//            // Added the "Progress" label above the progress bar.
//            Text("Progress").font(.caption).fontWeight(.semibold)
//            ProgressView(value: Double(course.progress), total: 100)
//                .progressViewStyle(LinearProgressViewStyle(tint: progressColor))
//            
//            HStack {
//                Text("\(course.testsCompleted)/\(course.totalTests) tests")
//                Spacer()
//                Text("\(course.progress)%")
//            }
//            .font(.caption)
//            .foregroundColor(.quizifyTextGray)
//        }
//        .padding(15)
//        .background(Color.white)
//        .cornerRadius(12)
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyLightGray.opacity(0.5)))
//    }
//}
//
//// A custom button style to replicate the outline effect from the original design.
//struct OutlineButtonStyle: ButtonStyle {
//    var color: Color
//
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .foregroundColor(color)
//            .background(Color.clear)
//            .cornerRadius(8)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(color, lineWidth: 1.5)
//            )
//            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
//            .opacity(configuration.isPressed ? 0.8 : 1.0)
//    }
//}
//
//// MARK: - Preview
//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//    }
//}



//import SwiftUI
//
//// The DashboardView is the central hub of the application, providing an at-a-glance
//// overview of the student's status, recent activities, and upcoming tests.
//struct DashboardView: View {
//    // The ViewModel provides the data for this view.
//    @StateObject private var viewModel = DashboardViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 30) {
//                // MARK: - Welcome Header
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("STUDENT DASHBOARD")
//                        .font(.caption)
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 5)
//                        .background(Color.quizifyAccentYellow)
//                        .foregroundColor(Color.quizifyDarkBackground)
//                        .cornerRadius(15)
//
//                    Text("Welcome back, John!")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("Here's what's happening with your classes and tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Stats Overview
//                // A grid with 5 flexible columns to ensure the cards distribute evenly
//                // across the full width of the screen, resolving the layout gap.
//                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 25), count: 5), spacing: 25) {
//                    StatCardView(title: "Classes", value: "5", description: "Active classes", icon: "books.vertical.fill", trend: "+1 this week", color: .quizifyPrimary)
//                    StatCardView(title: "Tests", value: "12", description: "Upcoming tests", icon: "pencil.and.ruler.fill", trend: "3 due soon", color: .quizifyAccentBlue)
//                    StatCardView(title: "Results", value: "87%", description: "Average score", icon: "chart.bar.xaxis", trend: "+2% from last month", color: .quizifyAccentGreen)
//                    StatCardView(title: "Completion", value: "92%", description: "Course progress", icon: "hourglass", trend: "On track for completion", color: .quizifyAccentYellow)
//                    StatCardView(title: "Study Streak", value: "14", description: "Days of consistent study", icon: "flame.fill", trend: "Keep it up!", color: .orange)
//                }
//
//                // MARK: - Main Content Grid
//                // A two-column grid for the main content sections, mimicking the React version's layout.
//                LazyVGrid(columns: [GridItem(.flexible(minimum: 400)), GridItem(.flexible(minimum: 400))], spacing: 30) {
//                    ActivitySectionView(activities: viewModel.activities)
//                    UpcomingTestsSectionView(tests: viewModel.upcomingTests)
//                }
//
//                // MARK: - Class Progress Section
//                // This section appears below the two-column grid, as in the original design.
//                ClassProgressSectionView(courses: viewModel.classProgress)
//            }
//            .padding(30)
//        }
//    }
//}
//
//// MARK: - ActivitySectionView
//struct ActivitySectionView: View {
//    let activities: [Activity]
//    
//    var body: some View {
//        TitledSection(
//            title: "Recent Activity",
//            description: "Your latest quiz results and class activities."
//        ) {
//            // Main content of the section
//            VStack(spacing: 15) {
//                if activities.isEmpty {
//                    Text("No recent activity to display.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(activities) { activity in
//                        ActivityRow(activity: activity)
//                    }
//                }
//            }
//        } footer: {
//            // Footer with a compact, centered button.
//            HStack {
//                Spacer()
//                Button(action: {}) {
//                    Label("View All Activity", systemImage: "arrow.up.right")
//                        .fontWeight(.semibold)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 8)
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//                Spacer()
//            }
//        }
//    }
//}
//
//// MARK: - UpcomingTestsSectionView
//struct UpcomingTestsSectionView: View {
//    let tests: [Test]
//
//    var body: some View {
//        TitledSection(
//            title: "Upcoming Tests",
//            description: "Tests scheduled in the next 7 days."
//        ) {
//            VStack(spacing: 12) {
//                if tests.isEmpty {
//                    Text("No upcoming tests.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(tests) { test in
//                        UpcomingTestRow(test: test)
//                    }
//                }
//            }
//        } footer: {
//            // Footer with a compact, centered button.
//            HStack {
//                Spacer()
//                Button(action: {}) {
//                    Label("View All Tests", systemImage: "arrow.up.right")
//                        .fontWeight(.semibold)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 8)
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyAccentBlue))
//                Spacer()
//            }
//        }
//    }
//}
//
//// MARK: - ClassProgressSectionView
//struct ClassProgressSectionView: View {
//    let courses: [Course]
//    
//    var body: some View {
//        TitledSection(title: "Class Progress", description: "An overview of your progress in active classes.") {
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                if courses.isEmpty {
//                    Text("No active classes to show progress for.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(courses) { course in
//                        ClassProgressRow(course: course)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Reusable Row and Section Components
//struct ActivityRow: View {
//    let activity: Activity
//    var body: some View {
//        HStack(spacing: 15) {
//            // Icon with a solid colored background and white foreground.
//            Image(systemName: activity.icon)
//                .font(.title2)
//                .foregroundColor(.white)
//                .frame(width: 50, height: 50)
//                .background(activity.color)
//                .clipShape(Circle())
//                
//            VStack(alignment: .leading, spacing: 2) {
//                Text(activity.title).fontWeight(.semibold)
//                Text(activity.description).font(.subheadline).foregroundColor(.quizifyTextGray)
//            }
//            Spacer()
//            // Timestamp with a clock icon.
//            Label(activity.time, systemImage: "clock")
//                .font(.caption)
//                .foregroundColor(.quizifyTextGray)
//        }
//        // Each activity item is now enclosed in a rounded container with a border.
//        .padding(12)
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyPrimary.opacity(0.3)))
//    }
//}
//
//struct UpcomingTestRow: View {
//    let test: Test
//    var body: some View {
//        // Removed the "View Details" button for a cleaner look and balanced card height.
//        HStack {
//            VStack(alignment: .leading) {
//                Text(test.title).fontWeight(.semibold)
//                Text(test.className).font(.subheadline).foregroundColor(.gray)
//            }
//            Spacer()
//            VStack(alignment: .trailing) {
//                Text(test.date).fontWeight(.semibold)
//                Text(test.time).font(.subheadline).foregroundColor(.gray)
//            }
//        }
//        .padding(12)
//        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.quizifyAccentBlue.opacity(0.3)))
//    }
//}
//
//struct ClassProgressRow: View {
//    let course: Course
//    
//    // Determines the color of the progress bar based on the progress value.
//    private var progressColor: Color {
//        if course.progress >= 75 { return .quizifyAccentGreen }
//        if course.progress >= 50 { return .quizifyAccentYellow }
//        return .quizifyRedError
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Text(course.name)
//                    .fontWeight(.bold)
//                Spacer()
//                // "Details" button styled to match the original design.
//                Button(action: {}) {
//                    Label("Details", systemImage: "arrow.up.right")
//                        .font(.caption)
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 4)
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//            }
//            Text(course.teacher)
//                .font(.caption)
//                .foregroundColor(.quizifyTextGray)
//
//            // Added the "Progress" label above the progress bar.
//            Text("Progress").font(.caption).fontWeight(.semibold)
//            ProgressView(value: Double(course.progress), total: 100)
//                .progressViewStyle(LinearProgressViewStyle(tint: progressColor))
//            
//            HStack {
//                Text("\(course.testsCompleted)/\(course.totalTests) tests")
//                Spacer()
//                Text("\(course.progress)%")
//            }
//            .font(.caption)
//            .foregroundColor(.quizifyTextGray)
//        }
//        .padding(15)
//        .background(Color.white)
//        .cornerRadius(12)
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyLightGray.opacity(0.5)))
//    }
//}
//
//// A custom button style to replicate the outline effect from the original design.
//struct OutlineButtonStyle: ButtonStyle {
//    var color: Color
//
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .foregroundColor(color)
//            .background(Color.clear)
//            .cornerRadius(8)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(color, lineWidth: 1.5)
//            )
//            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
//            .opacity(configuration.isPressed ? 0.8 : 1.0)
//    }
//}
//
//// MARK: - Preview
//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//    }
//}



import SwiftUI

// The DashboardView is the central hub of the application, providing an at-a-glance
// overview of the student's status, recent activities, and upcoming tests.
struct DashboardView: View {
    // The ViewModel provides the data for this view.
    @StateObject private var viewModel = DashboardViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                // MARK: - Welcome Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("STUDENT DASHBOARD")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(Color.quizifyAccentYellow)
                        .foregroundColor(Color.quizifyDarkBackground)
                        .cornerRadius(15)

                    Text("Welcome back, John!")
                        .font(.system(size: 28, weight: .bold))
                    Text("Here's what's happening with your classes and tests.")
                        .font(.title3)
                        .foregroundColor(.quizifyTextGray)
                }

                // MARK: - Stats Overview
                // A grid with 5 flexible columns to ensure the cards distribute evenly
                // across the full width of the screen, resolving the layout gap.
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 25), count: 5), spacing: 25) {
                    StatCardView(title: "Classes", value: "5", description: "Active classes", icon: "books.vertical.fill", trend: "+1 this week", color: .quizifyPrimary)
                    StatCardView(title: "Tests", value: "12", description: "Upcoming tests", icon: "pencil.and.ruler.fill", trend: "3 due soon", color: .quizifyAccentBlue)
                    StatCardView(title: "Results", value: "87%", description: "Average score", icon: "chart.bar.xaxis", trend: "+2% from last month", color: .quizifyAccentGreen)
                    StatCardView(title: "Completion", value: "92%", description: "Course progress", icon: "hourglass", trend: "On track for completion", color: .quizifyAccentYellow)
                    StatCardView(title: "Study Streak", value: "14", description: "Days of consistent study", icon: "flame.fill", trend: "Keep it up!", color: .orange)
                }

                // MARK: - Main Content Grid
                // A two-column grid for the main content sections, mimicking the React version's layout.
                LazyVGrid(columns: [GridItem(.flexible(minimum: 400)), GridItem(.flexible(minimum: 400))], spacing: 30) {
                    ActivitySectionView(activities: viewModel.activities)
                    UpcomingTestsSectionView(tests: viewModel.upcomingTests)
                }

                // MARK: - Class Progress Section
                // This section appears below the two-column grid, as in the original design.
                ClassProgressSectionView(courses: viewModel.classProgress)
            }
            .padding(30)
        }
    }
}

// MARK: - ActivitySectionView
struct ActivitySectionView: View {
    let activities: [Activity]
    
    var body: some View {
        TitledSection(
            title: "Recent Activity",
            description: "Your latest quiz results and class activities."
        ) {
            // Main content of the section
            VStack(spacing: 15) {
                if activities.isEmpty {
                    Text("No recent activity to display.").foregroundColor(.gray).padding()
                } else {
                    ForEach(activities) { activity in
                        ActivityRow(activity: activity)
                    }
                }
            }
        } footer: {
            // Footer with a compact, centered button.
            HStack {
                Spacer()
                Button(action: {}) {
                    Label("View All Activity", systemImage: "arrow.up.right")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                }
                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
                Spacer()
            }
        }
    }
}

// MARK: - UpcomingTestsSectionView
struct UpcomingTestsSectionView: View {
    let tests: [Test]

    var body: some View {
        TitledSection(
            title: "Upcoming Tests",
            description: "Tests scheduled in the next 7 days."
        ) {
            VStack(spacing: 12) {
                if tests.isEmpty {
                    Text("No upcoming tests.").foregroundColor(.gray).padding()
                } else {
                    ForEach(tests) { test in
                        UpcomingTestRow(test: test)
                    }
                }
            }
        } footer: {
            // Footer with a compact, centered button.
            HStack {
                Spacer()
                Button(action: {}) {
                    Label("View All Tests", systemImage: "arrow.up.right")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                }
                .buttonStyle(OutlineButtonStyle(color: .quizifyAccentBlue))
                Spacer()
            }
        }
    }
}

// MARK: - ClassProgressSectionView
struct ClassProgressSectionView: View {
    let courses: [Course]
    
    var body: some View {
        TitledSection(title: "Class Progress", description: "An overview of your progress in active classes.") {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                if courses.isEmpty {
                    Text("No active classes to show progress for.").foregroundColor(.gray).padding()
                } else {
                    ForEach(courses) { course in
                        ClassProgressRow(course: course)
                    }
                }
            }
        }
    }
}

// MARK: - Reusable Row and Section Components
struct ActivityRow: View {
    let activity: Activity
    var body: some View {
        HStack(spacing: 15) {
            // Icon with a solid colored background and white foreground.
            Image(systemName: activity.icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(activity.color)
                .clipShape(Circle())
                
            VStack(alignment: .leading, spacing: 2) {
                Text(activity.title).fontWeight(.semibold)
                Text(activity.description).font(.subheadline).foregroundColor(.quizifyTextGray)
            }
            Spacer()
            // Timestamp with a clock icon.
            Label(activity.time, systemImage: "clock")
                .font(.caption)
                .foregroundColor(.quizifyTextGray)
        }
        // Each activity item is now enclosed in a rounded container with a border.
        .padding(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyPrimary.opacity(0.3)))
    }
}

struct UpcomingTestRow: View {
    let test: Test
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(test.title).fontWeight(.semibold)
                Text(test.className).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(test.date).fontWeight(.semibold)
                Text(test.time).font(.subheadline).foregroundColor(.gray)
            }
        }
        // Set a minHeight to match the ActivityRow's icon height, ensuring vertical alignment.
        .frame(minHeight: 50, alignment: .center)
        .padding(12)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.quizifyAccentBlue.opacity(0.3)))
    }
}

struct ClassProgressRow: View {
    let course: Course
    
    // Determines the color of the progress bar based on the progress value.
    private var progressColor: Color {
        if course.progress >= 75 { return .quizifyAccentGreen }
        if course.progress >= 50 { return .quizifyAccentYellow }
        return .quizifyRedError
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(course.name)
                    .fontWeight(.bold)
                Spacer()
                // "Details" button styled to match the original design.
                Button(action: {}) {
                    Label("Details", systemImage: "arrow.up.right")
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                }
                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
            }
            Text(course.teacher)
                .font(.caption)
                .foregroundColor(.quizifyTextGray)

            // Added the "Progress" label above the progress bar.
            Text("Progress").font(.caption).fontWeight(.semibold)
            ProgressView(value: Double(course.progress), total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: progressColor))
            
            HStack {
                Text("\(course.testsCompleted)/\(course.totalTests) tests")
                Spacer()
                Text("\(course.progress)%")
            }
            .font(.caption)
            .foregroundColor(.quizifyTextGray)
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyLightGray.opacity(0.5)))
    }
}

// A custom button style to replicate the outline effect from the original design.
//struct OutlineButtonStyle: ButtonStyle {
//    var color: Color
//
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .foregroundColor(color)
//            .background(Color.clear)
//            .cornerRadius(8)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(color, lineWidth: 1.5)
//            )
//            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
//            .opacity(configuration.isPressed ? 0.8 : 1.0)
//    }
//}

// MARK: - Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}










//import SwiftUI
//
//// The DashboardView is the central hub of the application, providing an at-a-glance
//// overview of the student's status, recent activities, and upcoming tests.
//struct DashboardView: View {
//    // The ViewModel provides the data for this view.
//    @StateObject private var viewModel = DashboardViewModel()
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 30) {
//                // MARK: - Welcome Header
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("STUDENT DASHBOARD")
//                        .font(.caption)
//                        .fontWeight(.bold)
//                        .padding(.horizontal, 12)
//                        .padding(.vertical, 5)
//                        .background(Color.quizifyAccentYellow)
//                        .foregroundColor(Color.quizifyDarkBackground)
//                        .cornerRadius(15)
//
//                    Text("Welcome back, John!")
//                        .font(.system(size: 28, weight: .bold))
//                    Text("Here's what's happening with your classes and tests.")
//                        .font(.title3)
//                        .foregroundColor(.quizifyTextGray)
//                }
//
//                // MARK: - Stats Overview
//                // The stat cards are now dynamically generated by iterating over the
//                // data loaded into the view model.
//                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 25), count: 5), spacing: 25) {
//                    ForEach(viewModel.stats) { stat in
//                        StatCardView(stat: stat)
//                    }
//                }
//
//                // MARK: - Main Content Grid
//                // A two-column grid for the main content sections, mimicking the React version's layout.
//                LazyVGrid(columns: [GridItem(.flexible(minimum: 400)), GridItem(.flexible(minimum: 400))], spacing: 30) {
//                    ActivitySectionView(activities: viewModel.activities)
//                    UpcomingTestsSectionView(tests: viewModel.upcomingTests)
//                }
//
//                // MARK: - Class Progress Section
//                // This section appears below the two-column grid, as in the original design.
//                ClassProgressSectionView(courses: viewModel.classProgress)
//            }
//            .padding(30)
//        }
//    }
//}
//
//// MARK: - ActivitySectionView
//struct ActivitySectionView: View {
//    let activities: [Activity]
//    
//    var body: some View {
//        TitledSection(
//            title: "Recent Activity",
//            description: "Your latest quiz results and class activities."
//        ) {
//            // Main content of the section
//            VStack(spacing: 15) {
//                if activities.isEmpty {
//                    Text("No recent activity to display.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(activities) { activity in
//                        ActivityRow(activity: activity)
//                    }
//                }
//            }
//        } footer: {
//            // Footer with a compact, centered button.
//            HStack {
//                Spacer()
//                Button(action: {}) {
//                    Label("View All Activity", systemImage: "arrow.up.right")
//                        .fontWeight(.semibold)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 8)
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//                Spacer()
//            }
//        }
//    }
//}
//
//// MARK: - UpcomingTestsSectionView
//struct UpcomingTestsSectionView: View {
//    let tests: [Test]
//
//    var body: some View {
//        TitledSection(
//            title: "Upcoming Tests",
//            description: "Tests scheduled in the next 7 days."
//        ) {
//            VStack(spacing: 12) {
//                if tests.isEmpty {
//                    Text("No upcoming tests.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(tests) { test in
//                        UpcomingTestRow(test: test)
//                    }
//                }
//            }
//        } footer: {
//            // Footer with a compact, centered button.
//            HStack {
//                Spacer()
//                Button(action: {}) {
//                    Label("View All Tests", systemImage: "arrow.up.right")
//                        .fontWeight(.semibold)
//                        .padding(.horizontal, 20)
//                        .padding(.vertical, 8)
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyAccentBlue))
//                Spacer()
//            }
//        }
//    }
//}
//
//// MARK: - ClassProgressSectionView
//struct ClassProgressSectionView: View {
//    let courses: [Course]
//    
//    var body: some View {
//        TitledSection(title: "Class Progress", description: "An overview of your progress in active classes.") {
//            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                if courses.isEmpty {
//                    Text("No active classes to show progress for.").foregroundColor(.gray).padding()
//                } else {
//                    ForEach(courses) { course in
//                        ClassProgressRow(course: course)
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Reusable Row and Section Components
//struct ActivityRow: View {
//    let activity: Activity
//    var body: some View {
//        HStack(spacing: 15) {
//            // Icon with a solid colored background and white foreground.
//            Image(systemName: activity.icon)
//                .font(.title2)
//                .foregroundColor(.white)
//                .frame(width: 50, height: 50)
//                .background(activity.color)
//                .clipShape(Circle())
//                
//            VStack(alignment: .leading, spacing: 2) {
//                Text(activity.title).fontWeight(.semibold)
//                Text(activity.description).font(.subheadline).foregroundColor(.quizifyTextGray)
//            }
//            Spacer()
//            // Timestamp with a clock icon.
//            Label(activity.time, systemImage: "clock")
//                .font(.caption)
//                .foregroundColor(.quizifyTextGray)
//        }
//        // Each activity item is now enclosed in a rounded container with a border.
//        .padding(12)
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyPrimary.opacity(0.3)))
//    }
//}
//
//struct UpcomingTestRow: View {
//    let test: Test
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading) {
//                Text(test.title).fontWeight(.semibold)
//                Text(test.className).font(.subheadline).foregroundColor(.gray)
//            }
//            Spacer()
//            VStack(alignment: .trailing) {
//                Text(test.date).fontWeight(.semibold)
//                Text(test.time).font(.subheadline).foregroundColor(.gray)
//            }
//        }
//        // Set a minHeight to match the ActivityRow's icon height, ensuring vertical alignment.
//        .frame(minHeight: 50, alignment: .center)
//        .padding(12)
//        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.quizifyAccentBlue.opacity(0.3)))
//    }
//}
//
//struct ClassProgressRow: View {
//    let course: Course
//    
//    // Determines the color of the progress bar based on the progress value.
//    private var progressColor: Color {
//        if course.progress >= 75 { return .quizifyAccentGreen }
//        if course.progress >= 50 { return .quizifyAccentYellow }
//        return .quizifyRedError
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Text(course.name)
//                    .fontWeight(.bold)
//                Spacer()
//                // "Details" button styled to match the original design.
//                Button(action: {}) {
//                    Label("Details", systemImage: "arrow.up.right")
//                        .font(.caption)
//                        .padding(.horizontal, 10)
//                        .padding(.vertical, 4)
//                }
//                .buttonStyle(OutlineButtonStyle(color: .quizifyPrimary))
//            }
//            Text(course.teacher)
//                .font(.caption)
//                .foregroundColor(.quizifyTextGray)
//
//            // Added the "Progress" label above the progress bar.
//            Text("Progress").font(.caption).fontWeight(.semibold)
//            ProgressView(value: Double(course.progress), total: 100)
//                .progressViewStyle(LinearProgressViewStyle(tint: progressColor))
//            
//            HStack {
//                Text("\(course.testsCompleted)/\(course.totalTests) tests")
//                Spacer()
//                Text("\(course.progress)%")
//            }
//            .font(.caption)
//            .foregroundColor(.quizifyTextGray)
//        }
//        .padding(15)
//        .background(Color.white)
//        .cornerRadius(12)
//        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.quizifyLightGray.opacity(0.5)))
//    }
//}
//
//// A custom button style to replicate the outline effect from the original design.
//struct OutlineButtonStyle: ButtonStyle {
//    var color: Color
//
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .foregroundColor(color)
//            .background(Color.clear)
//            .cornerRadius(8)
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(color, lineWidth: 1.5)
//            )
//            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
//            .opacity(configuration.isPressed ? 0.8 : 1.0)
//    }
//}
//
//// MARK: - Preview
//struct DashboardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardView()
//    }
//}
