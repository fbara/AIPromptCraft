//
//  Prompt.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import Foundation
import SwiftData

@Model
class Prompt {
    var text: String
    var timestamp: Date
    var tags: [String]
    
    init(text: String, timestamp: Date, tags: [String]) {
        self.text = text
        self.timestamp = timestamp
        self.tags = tags
    }
}
