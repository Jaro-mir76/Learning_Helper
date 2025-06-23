//
//  Languages.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
class Language {
    @Attribute(.unique) var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Language {
    static let espanol = Language(name: "Español")
}
