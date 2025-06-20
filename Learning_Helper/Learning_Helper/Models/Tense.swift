//
//  Tense.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
class Tense {
    @Attribute(.unique) var name: String
    
    init(name: String) {
        self.name = name
    }
}
