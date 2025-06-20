//
//  Sentences.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
class Sentence {
    var translation: Translation
    var sentence: String
    
    init(translation: Translation, sentence: String) {
        self.translation = translation
        self.sentence = sentence
    }
}
