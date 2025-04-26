//
//  PromptViewModel.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import Foundation

class PromptViewModel: ObservableObject {
    @Published var generatedPrompts: [String] = []
    
    // MARK: Generate prompt variations
    func generatePromptVariations(_ prompt: String, count: Int, completion: @escaping ([String]) -> Void) {
        var variations: [String] = []
        for i in 1...count {
            variations.append("\(prompt) (Variation \(i))") // Placeholder for actual generation logic
        }
        
        generatedPrompts = variations
        completion(variations)
    }
}
