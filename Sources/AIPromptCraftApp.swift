//
//  AIPromptCraftApp.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import SwiftUI
import SwiftData

@main
struct AIPromptCraftApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Prompt.self, User.self])
        }
    }
}
