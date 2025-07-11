//
//  Tag.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 08.07.2025.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Tag: Identifiable, Sendable {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var tagName: String
    var tagIcon: String
    var tagColor: ColorData
    var words: [Word] = []
    var wordsForms: [WordForm] = []
    
    init(id: UUID = UUID(), tagName: String, tagIcon: String, tagColor: ColorData) {
        self.id = id
        self.tagName = tagName
        self.tagIcon = tagIcon
        self.tagColor = tagColor
    }
    
    init(id: UUID = UUID(), otherTag: Tag) {
        self.id = id
        self.tagName = otherTag.tagName
        self.tagIcon = otherTag.tagIcon
        self.tagColor = otherTag.tagColor
    }
}

extension Tag {
    static let tagIconsList = ["person", "book", "music.note", "cloud", "cloud.rain", "sun.max", "moon", "wind", "snowflake", "microphone", "message", "phone", "video", "envelope", "flag.pattern.checkered", "airplane", "figure.walk", "sailboat"
    ]
    static let tagExample = Tag(tagName: "test tag", tagIcon: Tag.tagIconsList[5], tagColor: ColorData.blue)
}
