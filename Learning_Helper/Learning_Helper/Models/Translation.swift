//
//  Translations.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
class Translation {
    var word: Word?
    @Attribute(.unique) var wordForm: String
    var tense: Tense
    var meaning: String
    @Relationship(deleteRule: .cascade, inverse: \UsageExample.translation) var usageExamples: [UsageExample]
    var counterTest: Int
    var counterTestSuccess: Int
    
    init(word: Word? = nil, wordForm: String, tense: Tense, meaning: String, usageExamples: [UsageExample] = [], counterTest: Int = 0, counterTestSuccess: Int = 0) {
        self.word = word
        self.wordForm = wordForm
        self.tense = tense
        self.meaning = meaning
        self.usageExamples = usageExamples
        self.counterTest = counterTest
        self.counterTestSuccess = counterTestSuccess
    }
}
