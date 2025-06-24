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
    @Relationship(deleteRule: .cascade, inverse: \Meaning.translation) var meaning: [Meaning]
    @Relationship(deleteRule: .cascade, inverse: \UsageExample.translation) var usageExamples: [UsageExample]
    var counterTest: Int
    var counterTestSuccess: Int
    var translationStatus: StatusCode.RawValue
    
    init(word: Word? = nil, wordForm: String, tense: Tense, meaning: [Meaning] = [], usageExamples: [UsageExample] = [], counterTest: Int = 0, counterTestSuccess: Int = 0, translationStatus: StatusCode) {
        self.word = word
        self.wordForm = wordForm
        self.tense = tense
        self.meaning = meaning
        self.usageExamples = usageExamples
        self.counterTest = counterTest
        self.counterTestSuccess = counterTestSuccess
        self.translationStatus = translationStatus.rawValue
    }
}
