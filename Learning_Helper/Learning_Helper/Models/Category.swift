//
//  Category.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
final class Category: Sendable {
    @Attribute(.unique) var myId: UUID
    @Attribute(.unique) var name: String
    var categoryDescription: String?
    
    init(myId: UUID = UUID(), name: String, categoryDescription: String? = nil) {
        self.myId = myId
        self.name = name
        self.categoryDescription = categoryDescription
    }
    
    init(myId: UUID = UUID(), otherCategory: Category) {
        self.myId = myId
        self.name = otherCategory.name
        self.categoryDescription = otherCategory.categoryDescription
    }
}

extension Category {
    static let myWords = Category(name: "My words", categoryDescription: "Wszystkie słówka które potrzebuje trenować.")
}
