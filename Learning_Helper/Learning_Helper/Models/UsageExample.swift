//
//  Sentences.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
class UsageExample {
    @Attribute(.unique) var id: UUID
    var translation: WordForm?
    var sentence: String
    var meaning: String
    var exampleStatus: StatusCode.RawValue
    
    init(id: UUID = UUID(), translation: WordForm? = nil, sentence: String, meaning: String, exampleStatus: StatusCode) {
        self.id = id
        self.translation = translation
        self.sentence = sentence
        self.meaning = meaning
        self.exampleStatus = exampleStatus.rawValue
    }
}
