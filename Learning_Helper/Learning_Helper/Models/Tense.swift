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
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var name: String
    var tenseDescription: String?
    
    init(id: UUID = UUID(), name: String, tenseDescription: String? = nil) {
        self.id = id
        self.name = name
        self.tenseDescription = tenseDescription
    }
}

extension Tense {
    static let presente = Tense(name: "Presente")
    static let preterito = Tense(name: "Pretérito")
}
