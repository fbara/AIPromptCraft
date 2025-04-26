//
//  LoginView.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var showTips = true
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            Text("Welcome to AIPromptCraft")
                .font(.largeTitle)
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.horizontal)
            }
            
            Button(isRegistering ? "Register" : "Log In") {
                errorMessage = nil
                if isRegistering {
                    viewModel.register(email: email, password: password)
                } else {
                    viewModel.login(email: email, password: password)
                }
                if !viewModel.isAuthenticated && !isRegistering {
                    errorMessage = "Invalid email or password"
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(email.isEmpty || password.isEmpty)
            .padding()
            
            Button(isRegistering ? "Already have an account? Log In" : "Need an account? Register") {
                isRegistering.toggle()
                errorMessage = nil
            }
            .foregroundColor(.blue)
            
            if showTips {
                Text("Tip: Register or log in to save and edit your prompts.")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top)
            }
        }
        .padding()
        .onAppear {
            if UserDefaults.standard.bool(forKey: "disableTips") {
                showTips = false
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let authViewModel = AuthViewModel()
    authViewModel.setModelContext(container.mainContext)
    return LoginView(viewModel: authViewModel)
}
