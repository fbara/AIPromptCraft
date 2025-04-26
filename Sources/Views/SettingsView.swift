//
//  SettingsView.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showTips: Bool
    @State private var selectedAISite: String?
    
    init() {
        _showTips = State(initialValue: !UserDefaults.standard.bool(forKey: "disableTips"))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    Toggle("Show Tips", isOn: $showTips)
                        .onChange(of: showTips) { oldValue, newValue in
                            UserDefaults.standard.set(!newValue, forKey: "disableTips")
                        }
                }
                
                Section(header: Text("AI Site Integration")) {
                    Picker("Select AI Site", selection: $selectedAISite) {
                        Text("None").tag(String?.none)
                        Text("Custom").tag(String?.some("Custom"))
                    }
                    
                    if selectedAISite != nil {
                        SecureField("API Key", text: .constant("")) // Placeholder for secure storage
                    }
                }
                
                Section {
                    Button("Log Out", role: .destructive, action: viewModel.logOut)
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: viewModel.cancelChanges)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: viewModel.saveChanges)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
