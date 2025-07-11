//
//  Learning_HelperTests.swift
//  Learning_HelperTests
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Testing
import SwiftData
import Foundation
@testable import Learning_Helper

struct Learning_HelperTests {

    @Test
    func gatherStatisticsBuildStatistics() throws {
        
//        Task { @MainActor in
//            do {
//                let context = try PreviewHelper.previewContext()
//                let fetchDescriptor = FetchDescriptor<Translation>(sortBy: [SortDescriptor(\.wordForm)])
//                let translations = try context.mainContext.fetch(fetchDescriptor)
//                #expect(translations.count > 0)
//
//            } catch {
//                print ("Something went wrong with fetching data from the context.")
//            }
//        }
        
    }
    
    @Test
    func countWordsInContext() throws {
        
//        Task { @MainActor in
//            do {
//                let context = try PreviewHelper.previewContext()
//                let fetchDescriptor = FetchDescriptor<Word>(sortBy: [SortDescriptor(\.name)])
//                let words = try context.mainContext.fetch(fetchDescriptor)
//                #expect(words.count > 0)
//
//            } catch {
//                print ("Something went wrong with fetching data from the context.")
//            }
//        }
        
    }
    
    @Test("Test fill the gap in foreign sentence.")
    func testFillGapInSentence() throws {
        let wordForm = Word.examples.first(where: {$0.name == "gracia"})?.forms.first(where: {$0.name == "gracia"})
        let wordForm2 = Word.examples.first(where: {$0.name == "decir"})?.forms.first(where: {$0.name == "digo"})
        let learningEngine = LearningEngine()
        
//        test for "gracia"
        var question: String = ""
        var question2: String = ""
        var answer: [String] = []
        (question, question2, answer) = learningEngine.fillGapInForeignSentence(wordForm: wordForm!)
        #expect(question == "Dziękuję bardzo")
        #expect(question2 == "Muchos #wordMask#, muchos #wordMask#!")
        #expect(answer[0] == "gracias")
        #expect(answer[1] == "graciasss")
        
//        test for "digo"
        question = ""
        question2 = ""
        answer = []
        (question, question2, answer) = learningEngine.fillGapInForeignSentence(wordForm: wordForm2!)
        #expect(question == "Mówię jej coś ważnego.")
        #expect(question2 == "Yo le #wordMask# a ella algo importante.")
        #expect(answer[0] == "digo")
    }

}
