//
//  User.swift
//  App Name: AIPromptCraft
//
//  Created by Frank Bara on 4/20/25
//

import Foundation
import SwiftData

@Model
class User {
    var email: String
    var password: String // In production, use hashed passwords
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
