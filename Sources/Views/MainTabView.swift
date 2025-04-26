//
//  MainTabView.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            PromptCreationView()
                .tabItem {
                    Label("Create", systemImage: "plus.circle")
                }
            PromptHistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    MainTabView()
}
