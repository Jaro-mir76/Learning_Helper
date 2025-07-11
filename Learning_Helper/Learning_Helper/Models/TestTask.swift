//
//  TestTask.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 09.07.2025.
//

import Foundation

struct TestTask {
    var wordId: UUID
    var taskType: TaskType
    var question: String
    var question2: String? = nil
    var answers: [String]
    var passed: Bool? = nil
}

enum TaskType: Int {
    case translateWordToNative = 0
    case translateWordToForeign
    case translateSentenceToNative
    case translateSentenceToForeign
    case fillGapInForeignSentence
//    case fillGapInNativeSentence
    
    var niceName: String {
        switch self {
        case .translateWordToNative:
            return "Translate word to your language."
        case .translateWordToForeign:
            return "Translate word to foreign language."
        case .translateSentenceToNative:
            return "Translate sentence to your language."
        case .translateSentenceToForeign:
            return "Translate sentence to foreign language."
        case .fillGapInForeignSentence:
            return "Fill gaps in sentence."
        }
    }
}
