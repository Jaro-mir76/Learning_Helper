//
//  Words.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
final class Word: Comparable, Sendable {
    @Attribute(.unique) var id: UUID
    @Attribute(.unique) var name: String
    var language: Language?
    var tags: [Tag]
    @Relationship(deleteRule: .cascade, inverse: \WordForm.origin) var forms: [WordForm]
//    @Transient var statistics: [LearningStatistics]?
    
    init(id: UUID = UUID(), name: String, language: Language? = nil, tags: [Tag] = [], forms: [WordForm] = []) {
        self.id = id
        self.name = name
        self.language = language
        self.tags = tags
        self.forms = forms
//        self.statistics = statistics
    }
    
    static func < (lhs: Word, rhs: Word) -> Bool {
        return lhs.name < rhs.name
    }
    
    func copy(_ from: Word) {
        self.id = from.id
        self.name = from.name
        if let language = from.language {
            self.language = Language(otherLanguage: language)
        } else {
            self.language = nil
        }
        if !from.tags.isEmpty {
            for tag in from.tags {
                self.tags.append(Tag(otherTag: tag))
            }
        } else {
            self.tags = []
        }
        self.forms = []
        for form in from.forms {
            self.forms.append(WordForm(otherWordForm: form))
        }
    }
}

extension Word {
    static let examples: [Word] = [
        Word(
            name: "gracia",
            language: Language.espanol,
            forms: [
                WordForm(
                    name: "gracias",
                    tense: Tense.presente,
                    meaning: [Meaning(meaning: "dziękuję")],
                    usageExamples: [
                        UsageExample(
                            sentence: "Muchos gracias",
                            meaning: "Dziękuję bardzo",
                            exampleStatus: StatusCode.ok
                        )
                    ],
                    counterTest: 3,
                    counterTestSuccess: 1,
                    progressIndicator: 0.3,
                    translationStatus: StatusCode.ok
                ),
                WordForm(
                    name: "gracia",
                    tense: Tense.presente,
                    meaning: [
                        Meaning(meaning: "łaska"),
                        Meaning(meaning: "uprzejmość")
                    ],
                    usageExamples: [
                        UsageExample(
                            sentence: "Muchos gracias, muchos graciasss!",
                            meaning: "Dziękuję bardzo",
                            exampleStatus: StatusCode.ok
                        )
                    ],
                    counterTest: 3,
                    counterTestSuccess: 1,
                    progressIndicator: 0.3,
                    translationStatus: StatusCode.ok
                )
            ]
        ),
        Word(
            name: "decir",
            language: Language.espanol,
            forms: [
                WordForm(
                    name: "digo",
                    tense: Tense.presente,
                    meaning: [Meaning(meaning: "mówię")],
                    usageExamples: [
                        UsageExample(
                            sentence: "Yo le digo a ella algo importante.",
                            meaning: "Mówię jej coś ważnego.",
                            exampleStatus: StatusCode.ok
                        )
                    ],
                    counterTest: 4,
                    counterTestSuccess: 1,
                    progressIndicator: 0.25,
                    translationStatus: StatusCode.toBeVerified
                ),
                WordForm(
                    name: "dije",
                    tense: Tense.preterito,
                    meaning: [Meaning(meaning: "powiedziałem")],
                    usageExamples: [
                        UsageExample(
                            sentence: "Yo dije ella algo importante.",
                            meaning: "Powiedziałem jej coś ważnego.",
                            exampleStatus: StatusCode.ok
                        ),
                        UsageExample(
                            sentence: "Yo dije que no puedo hacer esto.",
                            meaning: "Powiedziałem że nie mogę tego zrobić.",
                            exampleStatus: StatusCode.toBeVerified
                        )
                    ],
                    counterTest: 5,
                    counterTestSuccess: 1,
                    progressIndicator: 0.2,
                    translationStatus: StatusCode.ok
                )
            ]
        ),
        Word(
            name: "hacer",
            language: Language.espanol,
            forms: [
                WordForm(
                    name: "hago",
                    tense: Tense.presente,
                    meaning: [Meaning(meaning: "robię")],
                    usageExamples: [
                        UsageExample(
                            sentence: "Yo hago algo importante.",
                            meaning: "Robię coś ważnego.",
                            exampleStatus: StatusCode.ok
                        )
                    ],
                    translationStatus: StatusCode.ok
                ),
                WordForm(
                    name: "hice",
                    tense: Tense.preterito,
                    meaning: [Meaning(meaning: "zrobiłem")],
                    usageExamples: [
                        UsageExample(
                            sentence: "Hice algo para me.",
                            meaning: "Zrobiłem coś dla siebie.",
                            exampleStatus: StatusCode.ok
                        ),
                        UsageExample(
                            sentence: "Hice que fue necesito.",
                            meaning: "Zrobiłem co było potrzebne.",
                            exampleStatus: StatusCode.toBeVerified
                        )
                    ],
                    counterTest: 10,
                    counterTestSuccess: 1,
                    progressIndicator: 0.1,
                    translationStatus: StatusCode.wrong
                )
            ]
        )
    ]
}
