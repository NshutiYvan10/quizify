//
//  ClassesView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import SwiftUI

// The ClassesView displays all the courses the user is enrolled in.
// It uses a tabbed interface to separate active and completed classes.
struct ClassesView: View {
    // The ViewModel provides the class data.
    @StateObject private var viewModel = ClassesViewModel()
    // State to manage the selected tab ("Active" or "Completed").
    @State private var selectedTab: ClassTab = .active

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // MARK: - Header and Tab Picker
                HStack {
                    VStack(alignment: .leading) {
                        Text("My Classes")
                            .font(.system(size: 28, weight: .bold))
                        Text("Manage and access all your enrolled classes.")
                            .font(.title3)
                            .foregroundColor(.quizifyTextGray)
                    }
                    Spacer()
                    // The segmented picker acts as the tab switcher.
                    Picker("Class Status", selection: $selectedTab) {
                        ForEach(ClassTab.allCases) { tab in
                            Text(tab.rawValue).tag(tab)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: 300)
                }

                // MARK: - Classes Grid
                // An adaptive grid to display the class cards.
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 380), spacing: 25)], spacing: 25) {
                    // Determine which list of classes to show based on the selected tab.
                    let classes = selectedTab == .active ? viewModel.activeClasses : viewModel.completedClasses
                    ForEach(classes) { course in
                        ClassCardView(course: course)
                    }
                }
            }
            .padding(30)
        }
    }
}

// Enum to define the tabs for the class view.
enum ClassTab: String, CaseIterable, Identifiable {
    case active = "Active"
    case completed = "Completed"
    var id: String { self.rawValue }
}

// MARK: - ClassCardView
// A detailed card view for displaying a single class.
struct ClassCardView: View {
    let course: Course

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // MARK: Cover Image
            // AsyncImage loads the image from the URL provided in the JSON data.
            AsyncImage(url: URL(string: course.coverImage)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    // Placeholder in case of an error.
                    Rectangle().fill(Color.gray.opacity(0.3))
                } else {
                    // Placeholder while the image is loading.
                    ProgressView()
                }
            }
            .frame(height: 160)
            // Apply corner radius only to the top corners.
//            .cornerRadius(16, corners: [.topLeft, .topRight])

            // MARK: Card Content
            VStack(alignment: .leading, spacing: 15) {
                // Class Title and Subject
                VStack(alignment: .leading, spacing: 4) {
                    Text(course.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(course.subject)
                        .font(.headline)
                        .foregroundColor(.quizifyTextGray)
                }
                
                // Teacher Info
                HStack {
                    AsyncImage(url: URL(string: course.teacherAvatar ?? "")) { phase in
                        if let image = phase.image {
                            image.resizable().clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle.fill").resizable()
                        }
                    }
                    .frame(width: 30, height: 30)
                    Text(course.teacher).font(.subheadline).foregroundColor(.quizifyTextGray)
                }

                // Class Stats
                HStack {
                    Label("\(course.students) Students", systemImage: "person.2.fill")
                    Spacer()
                    Label("\(course.totalTests) Tests", systemImage: "pencil.and.ruler.fill")
                    Spacer()
                    Label(course.schedule, systemImage: "calendar")
                }
                .font(.subheadline)
                .foregroundColor(.quizifyTextGray)

                // Progress Bar
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Progress")
                        Spacer()
                        Text("\(course.progress)%").fontWeight(.semibold)
                    }
                    ProgressView(value: Double(course.progress), total: 100)
                        .progressViewStyle(LinearProgressViewStyle(tint: course.themeColor))
                }
            }
            .padding(20)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Preview
struct ClassesView_Previews: PreviewProvider {
    static var previews: some View {
        ClassesView()
    }
}
