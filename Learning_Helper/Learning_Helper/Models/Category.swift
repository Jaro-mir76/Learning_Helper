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
    var categoryDescription: String?
    
    init(id: UUID = UUID(), name: String, categoryDescription: String? = nil) {
        self.id = id
        self.name = name
        self.categoryDescription = categoryDescription
    }
    
    init(id: UUID = UUID(), otherCategory: Category) {
        self.id = id
        self.name = otherCategory.name
        self.categoryDescription = otherCategory.categoryDescription
    }
}

extension Category {
    static let myWords = Category(name: "My words", categoryDescription: "Wszystkie słówka które potrzebuje trenować.")
}
