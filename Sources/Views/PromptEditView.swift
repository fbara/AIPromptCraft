//
//  PromptEditView.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import SwiftUI
import SwiftData

struct PromptEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var prompt: Prompt
    @State private var tagsText = ""
    
    var body: some View {
        Form {
            Section(header: Text("Prompt Text")) {
                TextEditor(text: $prompt.text)
                    .frame(height: 200)
            }
            
            Section(header: Text("Tags")) {
                TextField("Add tags (comma-separated)", text: $tagsText)
                    .onSubmit {
                        prompt.tags = tagsText.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces))  }
                        tagsText = ""
                    }
            }
        }
        .navigationTitle("Edit Prompt")
        .onAppear {
            tagsText = prompt.tags.joined(separator: ", ")
        }
        .onDisappear {
            try? modelContext.save()
        }
    }
}

#Preview {
    PromptEditView(prompt: Prompt(text: "Sample prompt", timestamp: Date(), tags: ["tag1"]))
        .environment(\.modelContext, try! ModelContainer(for: Prompt.self).mainContext)
}
