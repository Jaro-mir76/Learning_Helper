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
    var translation: Translation?
    var sentence: String
    var meaning: String
    var exampleStatus: StatusCode.RawValue
    
    init(translation: Translation? = nil, sentence: String, meaning: String, exampleStatus: StatusCode) {
        self.translation = translation
        self.sentence = sentence
        self.meaning = meaning
        self.exampleStatus = exampleStatus.rawValue
    }
}
