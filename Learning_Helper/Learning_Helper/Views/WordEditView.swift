//
//  WordEditView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 21.06.2025.
//

import SwiftUI

struct WordEditView: View {
    @Environment(CoordinationManager.self) private var coordinationManager
    @Environment(\.dismiss) private var dismiss
    var word: Word?
    
    @State private var tense: Tense? = nil
    @State private var language: Language? = nil
    @State private var category: Category? = nil
    @State private var newWord = ""
    @State private var newWordForm = ""
    @State private var newMeaning = ""
    @State private var newUsageExampleSentence = ""
    @State private var newUsageExampleMeaning = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("your new word", text: $newWord )
                    LanguagePickerView(language: $language)
//                    CategoryPickerView(category: $category)
                }
                Section {
                    TextField("another form of your word", text: $newWordForm )
//                    TensePickerView(tense: $tense)
                    TextField("meaning", text: $newMeaning)
                    TextField("usage examples - sentence", text: $newUsageExampleSentence)
                    TextField("usage examples - meaning", text: $newUsageExampleMeaning)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        
                    } label: {
                        Text("Add")
                    }

                }
//                ToolbarItem(placement: .cancellationAction) {
//                    Button {
//                        dismiss()
//                        coordinationManager.selectedWord = nil
//                    } label: {
//                        Text("Cancel")
//                    }
//
//                }
            }
        }
    }
}

#Preview {
    WordEditView()
        .environment(CoordinationManager())
}
