//
//  PromptCardView.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import SwiftUI

struct PromptCardView: View {
    let prompt: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)
            
            Text(prompt)
                .padding()
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

#Preview {
    PromptCardView(prompt: "Sample prompt text")
}
