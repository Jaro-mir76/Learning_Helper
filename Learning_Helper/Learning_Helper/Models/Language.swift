//
//  Languages.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
class Language: Identifiable {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

extension Language {
    static let espanol = Language(name: "Español")
}
