//
//  Languages.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
final class Language: Identifiable, Sendable {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var name: String
    @Attribute(.unique) var flag: String?
    
    init(id: UUID = UUID(), name: String, flag: String? = nil) {
        self.id = id
        self.name = name
        self.flag = flag
    }
    
    init(id: UUID = UUID(), otherLanguage: Language) {
        self.id = id
        self.name = otherLanguage.name
        self.flag = otherLanguage.flag
    }
}

extension Language {
    static let espanol = Language(name: "Español")
}
