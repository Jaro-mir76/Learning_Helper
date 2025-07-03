//
//  Translations.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
class WordForm {
    @Attribute(.unique) var id: UUID
    var origin: Word?
    @Attribute(.unique) var name: String
    var tense: Tense?
    @Relationship(deleteRule: .cascade, inverse: \Meaning.translation) var meanings: [Meaning]
    @Relationship(deleteRule: .cascade, inverse: \UsageExample.translation) var usageExamples: [UsageExample]
    var counterTest: Int
    var counterTestSuccess: Int
    var progressIndicator: Double
    var translationStatus: StatusCode.RawValue
    
    init(id: UUID = UUID(), word: Word? = nil, name: String, tense: Tense? = nil, meaning: [Meaning] = [], usageExamples: [UsageExample] = [], counterTest: Int = 0, counterTestSuccess: Int = 0, progressIndicator: Double = 0, translationStatus: StatusCode) {
        self.id = id
        self.origin = word
        self.name = name
        self.tense = tense
        self.meanings = meaning
        self.usageExamples = usageExamples
        self.counterTest = counterTest
        self.counterTestSuccess = counterTestSuccess
        self.progressIndicator = progressIndicator
        self.translationStatus = translationStatus.rawValue
    }
    
    init(id: UUID = UUID(), otherWordForm: WordForm){
        self.id = id
        self.origin = otherWordForm.origin
        self.name = otherWordForm.name
        self.tense = otherWordForm.tense
        var tmpMeanings: [Meaning] = []
        for meaning in otherWordForm.meanings {
            tmpMeanings.append(Meaning(otherMeaning: meaning))
        }
        self.meanings = tmpMeanings
        var tmpExamples: [UsageExample] = []
        for example in otherWordForm.usageExamples {
            tmpExamples.append(UsageExample(otherUsageExample: example))
        }
        self.usageExamples = tmpExamples
        self.counterTest = otherWordForm.counterTest
        self.counterTestSuccess = otherWordForm.counterTestSuccess
        self.progressIndicator = otherWordForm.progressIndicator
        self.translationStatus = otherWordForm.translationStatus
    }
}
