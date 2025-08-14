//
//  ProfileViewModel.swift
//  Quizify2.0
//
//  Created by Inyambo Auca on 31/07/2025.
//

import Foundation
import Combine

// This ViewModel loads the user's profile data.
class ProfileViewModel: ObservableObject {
    @Published var profile: UserProfile?

    init() {
        self.profile = load("profile")
    }
}
