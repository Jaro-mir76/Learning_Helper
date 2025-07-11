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
    @Relationship(deleteRule: .nullify, inverse: \Tag.wordsForms) var tags: [Tag]
    var counterTest: Int
    var counterTestSuccess: Int
    var progressIndicator: Double
    var lastTestDate: Date?
    var translationStatus: StatusCode.RawValue
    
    init(id: UUID = UUID(), word: Word? = nil, name: String, tense: Tense? = nil, meaning: [Meaning] = [], usageExamples: [UsageExample] = [], tags: [Tag] = [], counterTest: Int = 0, counterTestSuccess: Int = 0, progressIndicator: Double = 0, lastTestDate: Date? = nil, translationStatus: StatusCode) {
        self.id = id
        self.origin = word
        self.name = name
        self.tense = tense
        self.meanings = meaning
        self.usageExamples = usageExamples
        self.tags = tags
        self.counterTest = counterTest
        self.counterTestSuccess = counterTestSuccess
        self.progressIndicator = progressIndicator
        self.lastTestDate = lastTestDate
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
        var tmpTags: [Tag] = []
        for tag in otherWordForm.tags {
            tmpTags.append(Tag(otherTag: tag))
        }
        self.tags = tmpTags
        self.counterTest = otherWordForm.counterTest
        self.counterTestSuccess = otherWordForm.counterTestSuccess
        self.progressIndicator = otherWordForm.progressIndicator
        self.lastTestDate = otherWordForm.lastTestDate
        self.translationStatus = otherWordForm.translationStatus
    }
    
    func recordSuccess() {
        print ("update - recordSuccess \(self.progressIndicator)")
        self.counterTest += 1
        self.counterTestSuccess += 1
        self.progressIndicator = Double (self.counterTestSuccess) / Double (self.counterTest)
        print ("after update of Progress Indicator: \(self.progressIndicator)")
    }
    
    func recordFailure() {
        print ("update - recordFailure \(self.progressIndicator)")
        self.counterTest += 1
        if self.counterTestSuccess > 0 {
            self.progressIndicator = Double (self.counterTestSuccess) / Double (self.counterTest)
        } else {
            self.progressIndicator = 0
        }
        
        print ("update - recordFailure \(self.progressIndicator)")
    }
}
