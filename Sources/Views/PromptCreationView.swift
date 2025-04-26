//
//  PromptCreationView.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import SwiftUI
import SwiftData

struct PromptCreationView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = PromptViewModel()
    @State private var promptText = ""
    @State private var variationsCount = 1
    @State private var selectedPromptIndex = 0
    
    var body: some View {
        VStack {
            TextField("Enter your prompt", text: $promptText)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Stepper("Variations: \(variationsCount)", value: $variationsCount, in: 1...10)
                .padding()
            
            Button("Generate Prompts") {
                viewModel.generatePromptVariations(promptText, count: variationsCount) { prompts in
                    savePrompts(prompts)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(promptText.isEmpty)
            
            if !viewModel.generatedPrompts.isEmpty {
                TabView(selection: $selectedPromptIndex) {
                    ForEach(viewModel.generatedPrompts.indices, id: \.self) { index in
                        PromptCardView(prompt: viewModel.generatedPrompts[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 300)
            }
        }
        .padding()
    }
    
    // MARK: Save generated prompts to SwiftData
    private func savePrompts(_ prompts: [String]) {
        for promptText in prompts {
            let newPrompt = Prompt(text: promptText, timestamp: Date(), tags: [])
            modelContext.insert(newPrompt)
        }
        try? modelContext.save()
    }
}

#Preview {
    PromptCreationView()
        .environment(\.modelContext, try! ModelContainer(for: Prompt.self).mainContext)
}
