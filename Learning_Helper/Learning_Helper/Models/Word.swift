//
//  Words.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
class Word {
    @Attribute(.unique) var name: String
    var language: Language
    var category: Category
    @Relationship(deleteRule: .cascade, inverse: \Translation.word) var translations: [Translation]
    
    init(name: String, language: Language, category: Category, translations: [Translation]) {
        self.name = name
        self.language = language
        self.category = category
        self.translations = translations
    }
}
