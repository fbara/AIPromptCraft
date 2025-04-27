//
//  ContentView.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                MainTabView()
            } else {
                LoginView(viewModel: authViewModel)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            authViewModel.setModelContext(modelContext)
        }
    }
}

#Preview("Authenticated") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Prompt.self, User.self, configurations: config)
    let authViewModel = AuthViewModel()
    authViewModel.isAuthenticated = true
    authViewModel.setModelContext(container.mainContext)
    return ContentView()
        .environment(\.modelContext, container.mainContext)
        .environmentObject(authViewModel)
}

#Preview("Unauthenticated") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Prompt.self, User.self, configurations: config)
    let context = container.mainContext
    let testUser = User(email: "test@example.com", password: "password123")
    context.insert(testUser)
    do {
        try context.save()
    } catch {
        print("Preview: Failed to save test user: \(error)")
    }
    
    let authViewModel = AuthViewModel()
    authViewModel.setModelContext(context)
    return ContentView()
        .environment(\.modelContext, container.mainContext)
        .environmentObject(authViewModel)
}

#Preview("Minimal") {
    ContentView()
}
