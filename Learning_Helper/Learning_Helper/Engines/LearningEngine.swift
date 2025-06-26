//
//  LearningEngine.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 25.06.2025.
//

import Foundation
import SwiftData

class LearningEngine {
    var statistics: [LearningStatistics] = []
    
    func gatherStatistics(modelContext: ModelContext) {
        
        self.statistics = []
        let fetchDescriptor = FetchDescriptor<WordForm>(sortBy: [SortDescriptor(\.origin), SortDescriptor(\.name)])
        let wordForms = try? modelContext.fetch(fetchDescriptor)
//        print ("translations \(wordForms?.count)")
        if let wordForms {
            for translation in wordForms {
//                print("translation id: \(translation.id) translation \(translation.name)")
                let stats = LearningStatistics(translationID: translation.id, counterTests: translation.counterTest, counterSuccess: translation.counterTestSuccess, progressIndicator: translation.progressIndicator)
                self.statistics.append(stats)
            }
        }
        print ("statistics gathered, elements no. \(self.statistics.count)")
        
//        let fetchDescriptorWords = FetchDescriptor<Word>(sortBy: [SortDescriptor(\.name)])
//        let words = try? modelContext.fetch(fetchDescriptorWords)
//        print ("words cout: \(words?.count ?? 0)")
//        if let words {
//            for w in words {
//                print ("word: \(w.name)")
//            }
//        }
    }
}
