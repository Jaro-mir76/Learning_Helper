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
    var translation: Translation?
    var meaning: String
    
    init(translation: Translation? = nil, meaning: String) {
        self.translation = translation
        self.meaning = meaning
    }
}
