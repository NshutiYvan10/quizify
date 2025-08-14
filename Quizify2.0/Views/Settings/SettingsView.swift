//
//  SettingsView.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import SwiftUI

// The SettingsView allows users to manage their personal information,
// account credentials, and notification preferences.
struct SettingsView: View {
    // State variables to hold the form data.
    // In a real app, this would be bound to a ViewModel or a data model.
    @State private var firstName = "John"
    @State private var lastName = "Smith"
    @State private var email = "john.smith@example.com"
    @State private var phone = "+1 (555) 123-4567"
    @State private var username = "johnsmith"
    
    @State private var emailNotifications = true
    @State private var pushNotifications = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                // MARK: - Header
                Text("Settings")
                    .font(.system(size: 28, weight: .bold))
                
                // MARK: - Settings Sections
                // The settings are organized into distinct cards for clarity.
                HStack(alignment: .top, spacing: 30) {
                    // Left column for profile and account settings.
                    VStack(spacing: 30) {
                        ProfileSettingsCard(firstName: $firstName, lastName: $lastName, email: $email, phone: $phone)
                        AccountSettingsCard(username: $username)
                    }
                    
                    // Right column for notification and privacy settings.
                    VStack(spacing: 30) {
                        NotificationSettingsCard(emailNotifications: $emailNotifications, pushNotifications: $pushNotifications)
                        PrivacySettingsCard()
                    }
                }
            }
            .padding(30)
        }
    }
}

// MARK: - Reusable Settings Cards
// A card for editing profile information.
struct ProfileSettingsCard: View {
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var phone: String

    var body: some View {
        TitledSection(title: "Profile Information", description: "Update your personal details.") {
            VStack(spacing: 15) {
                HStack {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                }
                TextField("Email Address", text: $email)
                TextField("Phone Number", text: $phone)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save Profile") {}
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

// A card for managing account settings like username and password.
struct AccountSettingsCard: View {
    @Binding var username: String
    @State private var currentPassword = ""
    @State private var newPassword = ""

    var body: some View {
        TitledSection(title: "Account Settings", description: "Manage your login credentials.") {
            VStack(spacing: 15) {
                TextField("Username", text: $username)
                SecureField("Current Password", text: $currentPassword)
                SecureField("New Password", text: $newPassword)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Update Password") {}
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

// A card for controlling notification preferences.
struct NotificationSettingsCard: View {
    @Binding var emailNotifications: Bool
    @Binding var pushNotifications: Bool

    var body: some View {
        TitledSection(title: "Notification Preferences", description: "Control how you receive alerts.") {
            VStack(spacing: 15) {
                Toggle("Email Notifications", isOn: $emailNotifications)
                Toggle("Push Notifications", isOn: $pushNotifications)
                Toggle("New Quiz Alerts", isOn: .constant(true))
                Toggle("Result Announcements", isOn: .constant(true))
            }
            .toggleStyle(SwitchToggleStyle(tint: .quizifyPrimary))
        }
    }
}

// A card for managing privacy settings.
struct PrivacySettingsCard: View {
    var body: some View {
        TitledSection(title: "Privacy", description: "Manage your data and account.") {
            VStack(spacing: 15) {
                Text("Manage how your data is used and shared.")
                    .foregroundColor(.quizifyTextGray)
                Button("Download Your Data") {}
                Button("Delete Your Account", role: .destructive) {}
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

