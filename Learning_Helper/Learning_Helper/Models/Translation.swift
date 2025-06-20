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
    var word: Word
    @Attribute(.unique) var wordForm: String
    var tense: Tense
    var meaning: String
    @Relationship(deleteRule: .cascade, inverse: \Sentence.translation) var sentences: [Sentence]
    var counterTest: Int
    var counterTestSuccess: Int
    
    init(word: Word, wordForm: String, tense: Tense, meaning: String, sentences: [Sentence], counterTest: Int, counterTestSuccess: Int) {
        self.word = word
        self.wordForm = wordForm
        self.tense = tense
        self.meaning = meaning
        self.sentences = sentences
        self.counterTest = counterTest
        self.counterTestSuccess = counterTestSuccess
    }
}
