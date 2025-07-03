//
//  WordEditView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 21.06.2025.
//

import SwiftUI

struct WordEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(CoordinationManager.self) private var coordinationManager
    @Environment(\.dismiss) private var dismiss
    @Bindable var word: Word
    
//    @State private var newWord = Word(name: "")
//    @State private var newForm = WordForm(name: "", translationStatus: StatusCode.new)
//    @State private var addNewFormPresent: Bool = false
    
//    @State private var tense: Tense? = nil
//    @State private var language: Language? = nil
//    @State private var category: Category? = nil
//    @State private var newWordName = ""
//    @State private var newWordForm = ""
//    @State private var newMeanings: [String] = []
//    @State private var newMeaning = ""
//    @State private var newUsageExamplesSentence: [String] = []
//    @State private var newUsageExamplesMeaning: [String] = []
//    @State private var newUsageExampleSentence = ""
//    @State private var newUsageExampleMeaning = ""
    
    private var windowTitle: String {
        coordinationManager.selectedWord == nil ? "Add word" : "Edit word: \(word.name)"
    }
    
    var body: some View {
        List {
            Section {
                TextField("your new word", text: $word.name )
                LanguagePickerView(language: $word.language)
                CategoryPickerView(category: $word.category)
            }
            ForEach(word.forms, id:\.id) { wordForm in
                WordFormView(wordForm: wordForm)
            }
            Button {
                addNewForm()
            } label: {
                Label("Add new form", systemImage: "plus")
            }
        }
        
//        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(windowTitle)
            }
//            ToolbarItem(placement: .confirmationAction) {
//                Button {
//                    save()
//                } label: {
//                    Text("Save")
//                }
//            }
//            ToolbarItem(placement: .cancellationAction) {
//                Button {
////                    cancel()
//                    save()
//                } label: {
//                    Label("Back", systemImage: "lessthan")
//                }
//            }
        }
    }
    
//    private func copyWord(from: Word, toWord: Word) {
//        toWord.copy(from)
//    }
    private func save() {
//      modelContext.insert(word)
        if coordinationManager.selectedWord == nil {
            if word.name != "" {
                modelContext.insert(word)
                try? modelContext.save()
            } else {
                modelContext.delete(word)
            }
        } else {
//            coordinationManager.selectedWord?.copy(word)
            try? modelContext.save()
        }
        dismiss()
        coordinationManager.selectedWord = nil
    }
    
//    private func cancel() {
//        if coordinationManager.selectedWord == nil {
//            modelContext.delete(word)
//            dismiss()
//        } else {
//            modelContext.rollback()
//            coordinationManager.selectedWord = nil
//            dismiss()
//        }
//    }
    
    private func addNewForm() {
        var newForm = WordForm(name: "", translationStatus: StatusCode.new)
        word.forms.append(newForm)
        coordinationManager.navigationPathDictionary.append(newForm)
    }
    
//    private func addMeaning() {
//        newMeanings.append(newMeaning)
//        newMeaning = ""
//    }
//    
//    private func addExample() {
//        newUsageExamplesSentence.append(newUsageExampleSentence)
//        newUsageExamplesMeaning.append(newUsageExampleMeaning)
//        newUsageExampleSentence = ""
//        newUsageExampleMeaning = ""
//    }
}

#Preview("Clean environment") {
    WordEditView(word: Word.examples[1])
        .environment(CoordinationManager())
}

#Preview("With default language") {
    @Previewable @State var coordinator = CoordinationManager(defaultLanguage: Language.espanol)
    WordEditView(word: Word.examples[0])
        .environment(coordinator)
}
