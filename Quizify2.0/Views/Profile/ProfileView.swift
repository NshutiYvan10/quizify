//
//  ProfileView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

//import SwiftUI
//
//// The ProfileView displays a comprehensive overview of the user's information,
//// including personal details, enrolled classes, and academic performance.
//struct ProfileView: View {
//    // The ViewModel provides the profile data.
//    @StateObject private var viewModel = ProfileViewModel()
//    // State to manage the selected tab in the right-hand column.
//    @State private var selectedTab: ProfileTab = .overview
//
//    var body: some View {
//        // A horizontal stack to create the two-column layout.
//        HStack(alignment: .top, spacing: 30) {
//            // Check if the profile data has been loaded.
//            if let profile = viewModel.profile {
//                // MARK: - Left Column (Profile Summary Card)
//                ProfileSummaryCard(profile: profile)
//                    .frame(width: 380)
//                    // A fixed position makes the card "sticky" at the top while scrolling.
//                    .offset(y: -50) // Adjust offset to position correctly
//                    
//
//                // MARK: - Right Column (Tabbed Content)
//                ScrollView {
//                    VStack(spacing: 25) {
//                        Picker("Profile Details", selection: $selectedTab) {
//                            ForEach(ProfileTab.allCases) { tab in
//                                Text(tab.rawValue).tag(tab)
//                            }
//                        }
//                        .pickerStyle(SegmentedPickerStyle())
//                        .frame(maxWidth: 500)
//                        
//                        // Display the content for the selected tab.
//                        switch selectedTab {
//                        case .overview:
//                            ProfileOverviewSection(profile: profile)
//                        case .classes:
//                            ProfileClassesSection(classes: profile.activeClasses)
//                        case .performance:
//                            ProfilePerformanceSection(performance: profile.performance, recentTests: profile.recentTests)
//                        }
//                    }
//                }
//            } else {
//                // Show a loading indicator while the profile data is being fetched.
//                ProgressView("Loading Profile...")
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//            }
//        }
//        .padding(30)
//    }
//}
//
//// Enum for the tabs in the profile view.
//enum ProfileTab: String, CaseIterable, Identifiable {
//    case overview = "Overview"
//    case classes = "Classes"
//    case performance = "Performance"
//    var id: String { self.rawValue }
//}
//
//// MARK: - ProfileSummaryCard
//// The "sticky" card on the left side of the profile screen.
//struct ProfileSummaryCard: View {
//    let profile: UserProfile
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            AsyncImage(url: URL(string: profile.avatarUrl ?? "")) { phase in
//                if let image = phase.image {
//                    image.resizable().aspectRatio(contentMode: .fill)
//                } else {
//                    Image(systemName: "person.fill").resizable().padding().foregroundColor(.white).background(.gray)
//                }
//            }
//            .frame(width: 120, height: 120)
//            .clipShape(Circle())
//            .overlay(Circle().stroke(Color.quizifyPrimary, lineWidth: 4))
//            .shadow(radius: 10)
//
//            VStack {
//                Text(profile.name).font(.title).fontWeight(.bold)
//                Text(profile.grade).font(.headline).foregroundColor(.quizifyTextGray)
//            }
//            
//            VStack(alignment: .leading, spacing: 15) {
//                InfoRow(icon: "envelope.fill", text: profile.email)
//                InfoRow(icon: "phone.fill", text: profile.phone)
//                InfoRow(icon: "location.fill", text: profile.address)
//                InfoRow(icon: "at", text: profile.username)
//            }
//            
//            Button(action: {}) {
//                Label("Edit Profile", systemImage: "pencil")
//                    .frame(maxWidth: .infinity)
//            }
//            .buttonStyle(.borderedProminent)
//            .tint(.quizifyPrimary)
//        }
//        .padding(30)
//        .background(Color.white)
//        .cornerRadius(16)
//        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
//    }
//}
//
//// A helper view for a row of information with an icon and text.
//struct InfoRow: View {
//    let icon: String
//    let text: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .foregroundColor(.quizifyPrimary)
//                .frame(width: 20)
//            Text(text)
//                .foregroundColor(.quizifyTextGray)
//        }
//    }
//}
//
//// MARK: - Tab Content Sections
//// The content for the "Overview" tab.
//struct ProfileOverviewSection: View {
//    let profile: UserProfile
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 25) {
//            TitledSection(title: "Academic Summary", description: "Your overall academic performance") {
//                HStack(spacing: 20) {
//                    ProfileStatView(value: "\(profile.activeClasses.count)", label: "Enrolled Classes")
//                    ProfileStatView(value: "\(profile.quizzesCompleted)", label: "Tests Completed")
//                    ProfileStatView(value: "\(Int(profile.averageScore))%", label: "Overall Grade")
//                }
//            }
//        }
//    }
//}
//
//// The content for the "Classes" tab.
//struct ProfileClassesSection: View {
//    let classes: [ProfileClass]
//    
//    var body: some View {
//        TitledSection(title: "Enrolled Classes", description: "Classes you are currently taking") {
//            VStack(spacing: 15) {
//                ForEach(classes) { cls in
//                    HStack {
//                        Image(systemName: "circle.fill")
//                            .foregroundColor(cls.themeColor)
//                        VStack(alignment: .leading) {
//                            Text(cls.name).fontWeight(.semibold)
//                            Text("\(cls.teacher) • \(cls.schedule)").font(.caption).foregroundColor(.gray)
//                        }
//                        Spacer()
//                        Text("\(cls.grade)%").fontWeight(.bold)
//                    }
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(12)
//                    .shadow(color: .black.opacity(0.03), radius: 4, y: 2)
//                }
//            }
//        }
//    }
//}
//
//// The content for the "Performance" tab.
//struct ProfilePerformanceSection: View {
//    let performance: [SubjectPerformance]
//    let recentTests: [ProfileTest]
//    
//    var body: some View {
//        HStack(alignment: .top, spacing: 25) {
//            TitledSection(title: "Performance by Subject", description: "Your performance across all subjects") {
//                VStack(spacing: 15) {
//                    ForEach(performance) { subject in
//                        VStack(alignment: .leading) {
//                            HStack {
//                                Text(subject.name).fontWeight(.semibold)
//                                Spacer()
//                                Text("\(subject.score)%").fontWeight(.bold)
//                            }
//                            ProgressView(value: Double(subject.score), total: 100)
//                        }
//                    }
//                }
//            }
//            TitledSection(title: "Recent Test Results", description: "Your most recent test performances") {
//                VStack(spacing: 15) {
//                    ForEach(recentTests) { test in
//                        HStack {
//                            Text(test.title)
//                            Spacer()
//                            Text("\(test.score)%").fontWeight(.bold)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//// MARK: - Reusable Helper Views
//// A view for a single statistic, used in the overview.
//struct ProfileStatView: View {
//    let value: String
//    let label: String
//    
//    var body: some View {
//        VStack {
//            Text(value)
//                .font(.system(size: 36, weight: .bold))
//                .foregroundColor(.quizifyPrimary)
//            Text(label)
//                .font(.headline)
//                .foregroundColor(.quizifyTextGray)
//        }
//        .frame(maxWidth: .infinity)
//        .padding()
//        .background(Color.white)
//        .cornerRadius(12)
//        .shadow(color: .black.opacity(0.03), radius: 4, y: 2)
//    }
//}
//
//// MARK: - Preview
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}


import SwiftUI

struct ProfileView: View {
    var body: some View {
        Text("Hello World")
            .font(.title)
            .fontWeight(.bold)
            .padding()
    }
}

#Preview {
    ProfileView()
}
