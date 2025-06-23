//
//  PreviewContex.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 23.06.2025.
//

import Foundation
import SwiftData

struct PreviewContex {
    static func previewContext() throws -> ModelContainer {
        let modelConfig = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: Word.self, configurations: modelConfig)
        Task { @MainActor in
            modelContainer.mainContext.insert(Word.examples[0])
            modelContainer.mainContext.insert(Word.examples[1])
            modelContainer.mainContext.insert(Word.examples[2])
        }
        return modelContainer
    }
}
