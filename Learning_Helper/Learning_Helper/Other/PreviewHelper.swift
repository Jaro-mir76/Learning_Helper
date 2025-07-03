//
//  PreviewContex.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 23.06.2025.
//

import Foundation
import SwiftData
import SwiftUI

struct PreviewHelper: PreviewModifier {
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
    
    static func makeSharedContext() throws -> ModelContainer {
        let modelConfig = ModelConfiguration(isStoredInMemoryOnly: true)
        let modelContainer = try ModelContainer(for: Word.self, WordForm.self, Language.self, Meaning.self, UsageExample.self, configurations: modelConfig)
        let espanol = Language(name: "Español")
        let english = Language(name: "English")
        let polish = Language(name: "Polski")
        
        let myWords = Category(name: "My words", categoryDescription: "all my words I need")
        let book = Category(name: "Book", categoryDescription: "Words from book.")
        
        let preterito = Tense.preterito
        let presente = Tense.presente
        
        Task { @MainActor in
            modelContainer.mainContext.insert(preterito)
            modelContainer.mainContext.insert(presente)
            
            modelContainer.mainContext.insert(myWords)
            modelContainer.mainContext.insert(book)
            
            modelContainer.mainContext.insert(espanol)
            modelContainer.mainContext.insert(english)
            modelContainer.mainContext.insert(polish)
            
            modelContainer.mainContext.insert(Word.examples[0])
            modelContainer.mainContext.insert(Word.examples[1])
            modelContainer.mainContext.insert(Word.examples[2])
        }
        return modelContainer
    }
}
