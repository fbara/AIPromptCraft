//
//  PromptHistoryView.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import SwiftUI
import SwiftData

struct PromptHistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var prompts: [Prompt]
    
    var body: some View {
        List {
            ForEach(prompts) { prompt in
                NavigationLink {
                    PromptEditView(prompt: prompt)
                } label: {
                    VStack(alignment: .leading) {
                        Text(prompt.text)
                            .lineLimit(2)
                        Text(prompt.timestamp, style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onDelete(perform: deletePrompts)
        }
        .navigationTitle("Prompt History")
    }
    
    // MARK: Delete prompts
    private func deletePrompts(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(prompts[index])
        }
        try? modelContext.save()
    }
}

#Preview {
    PromptHistoryView()
        .environment(\.modelContext, try! ModelContainer(for: Prompt.self).mainContext)
}
