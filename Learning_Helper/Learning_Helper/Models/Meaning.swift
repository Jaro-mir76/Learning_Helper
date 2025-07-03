//
//  Meaning.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 24.06.2025.
//

import Foundation
import SwiftData

@Model
class Meaning {
    @Attribute(.unique) var id: UUID
    var translation: WordForm?
    var meaning: String
    
    init(id: UUID = UUID(), translation: WordForm? = nil, meaning: String) {
        self.id = id
        self.translation = translation
        self.meaning = meaning
    }
    
    init(id: UUID = UUID(), otherMeaning: Meaning){
        self.id = id
        self.translation = otherMeaning.translation
        self.meaning = otherMeaning.meaning
    }
}
