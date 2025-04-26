//
//  AuthViewModel.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import Foundation
import SwiftData

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    private var modelContext: ModelContext?
    
    // MARK: Set model context for SwiftData
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    // MARK: Register new user
    func register(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            print("Error: Email or password is empty")
            return
        }
        guard let context = modelContext else {
            print("Error: ModelContext is nil")
            return
        }
        do {
            let newUser = User(email: email, password: password)
            context.insert(newUser)
            try context.save()
            isAuthenticated = true
            print("Registration successful for email: \(email)")
        } catch {
            print("Error registering user: \(error)")
        }
    }
    
    // MARK: Log in existing user
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            print("Error: Email or password is empty")
            return
        }
        guard let context = modelContext else {
            print("Error: ModelContext is nil")
            return
        }
        do {
            let fetchDescriptor = FetchDescriptor<User>(predicate: #Predicate { $0.email == email && $0.password == password })
            let users = try context.fetch(fetchDescriptor)
            if !users.isEmpty {
                isAuthenticated = true
                print("Login successful for email: \(email)")
            } else {
                print("Login failed: No user found with provided credentials")
            }
        } catch {
            print("Error logging in: \(error)")
        }
    }
    
    // MARK: Log out
    func logOut() {
        isAuthenticated = false
        print("User logged out")
    }
}
