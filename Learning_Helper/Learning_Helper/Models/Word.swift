//
//  Words.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import Foundation
import SwiftData

@Model
class Word {
    @Attribute(.unique) var name: String
    var language: Language
    var category: Category?
    @Relationship(deleteRule: .cascade, inverse: \Translation.word) var translations: [Translation]
    
    init(name: String, language: Language, category: Category? = nil, translations: [Translation] = []) {
        self.name = name
        self.language = language
        self.category = category
        self.translations = translations
    }
}

extension Word {
    static let examples: [Word] = [
        Word(
            name: "gracias",
            language: Language.espanol,
            translations: [
                Translation(
                    wordForm: "gracias",
                    tense: Tense.presente,
                    meaning: [Meaning(meaning: "dziękuję")],
                    usageExamples: [
                        UsageExample(
                            sentence: "Muchos gracias",
                            meaning: "Dziękuję bardzo",
                            exampleStatus: StatusCode.ok
                        )
                    ],
                    translationStatus: StatusCode.ok
                )
            ]
        ),
        Word(
            name: "decir",
            language: Language.espanol,
            translations: [
                Translation(
                    wordForm: "digo",
                    tense: Tense.presente,
                    meaning: [Meaning(meaning: "mówię")],
                    usageExamples: [
                        UsageExample(
                            sentence: "Yo digo ella algo importante.",
                            meaning: "Mówię jej coś ważnego.",
                            exampleStatus: StatusCode.ok
                        ),
                        UsageExample(
                            sentence: "Yo digo y tu no.",
                            meaning: "Ja mówię a ty nie.",
                            exampleStatus: StatusCode.toBeVerified
                        )
                    ],
                    translationStatus: StatusCode.toBeVerified
                ),
                Translation(
                    wordForm: "dije",
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
                    translationStatus: StatusCode.ok
                )
            ]
        ),
        Word(
            name: "hacer",
            language: Language.espanol,
            translations: [
                Translation(
                    wordForm: "hago",
                    tense: Tense.presente,
                    meaning: [Meaning(meaning: "robię")],
                    usageExamples: [
                        UsageExample(
                            sentence: "Yo digo ella algo importante.",
                            meaning: "Mówię jej coś ważnego.",
                            exampleStatus: StatusCode.ok
                        )
                    ],
                    translationStatus: StatusCode.ok
                ),
                Translation(
                    wordForm: "hice",
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
                    translationStatus: StatusCode.wrong
                )
            ]
        )
    ]
}
