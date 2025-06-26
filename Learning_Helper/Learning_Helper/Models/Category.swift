//
//  Category.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
class Category {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var name: String
    var categoryDescription: String
    
    init(id: UUID = UUID(), name: String, categoryDescription: String) {
        self.id = id
        self.name = name
        self.categoryDescription = categoryDescription
    }
}
