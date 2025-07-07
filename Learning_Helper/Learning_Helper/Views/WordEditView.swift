//
//  WordEditView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 21.06.2025.
//

import SwiftUI
import SwiftData

struct WordEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(CoordinationManager.self) private var coordinationManager
    @Environment(\.dismiss) private var dismiss
    @Query(sort: [SortDescriptor(\Word.name)]) private var dictionary: [Word]
    @Bindable var word: Word
    @FocusState private var wordIsFocused: Bool
    @State private var wordExist: Bool = false
    
    init (word: Word) {
        self.word = word
        let wordId = word.id
        self._dictionary = Query (filter: #Predicate {$0.id != wordId}, sort: [SortDescriptor(\Word.name, order: .forward)])
    }
    
    private var windowTitle: String {
        coordinationManager.selectedWord == nil ? "Add word" : "Edit word: \(word.name)"
    }
    
    var body: some View {
        ScrollView {
//            Section {
                HStack {
                    TextField("your new word", text: $word.name )
                        .textFieldStyle(.roundedBorder)
                        .focused($wordIsFocused)
                        .foregroundStyle(wordExist ? .red : .primary)
                        .onChange(of: word.name, initial: true) {
                            checkIfExist(word: word)
                        }
                        .task {
                            wordIsFocused = true
                        }
                    if wordExist {
                        Button {
                            loadExistingWord()
                        } label: {
                            Label("Switch to existing", systemImage: "square.and.arrow.down")
                                .labelStyle(.titleOnly)
                        }
                    }
                }
                HStack {
                    LanguagePickerView(language: $word.language)
                    Spacer()
                    CategoryPickerView(category: $word.category)
                }
                
//            }
//            Section {
                Button {
                    addNewForm()
                } label: {
                    Label("Add new form", systemImage: "plus")
                        .labelStyle(.titleOnly)
                }
                .buttonStyle(.bordered)
//            }
//            .modifier(BoxView())
            ForEach(word.forms, id:\.id) { wordForm in
                WordFormView(wordForm: wordForm)
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(windowTitle)
            }
        }
        .onDisappear {
            if !wordExist {
                modelContext.insert(word)
            } else {
                modelContext.delete(word)
            }
            try? modelContext.save()
        }
    }
    
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
        let newForm = WordForm(name: "", translationStatus: StatusCode.new)
        word.forms.append(newForm)
        coordinationManager.navigationPathDictionary.append(newForm)
    }
    
    private func checkIfExist(word: Word) {
        if word.name.count > 1 {
            if dictionary.first(where: {$0.name.lowercased() == word.name.lowercased()}) != nil {
                wordExist = true
            } else {
                wordExist = false
            }
        } else {
            wordExist = false
        }
    }
    
    private func loadExistingWord() {
        if let existingWord = dictionary.first(where: {$0.name.lowercased() == word.name.lowercased()}) {
            coordinationManager.selectedWord = existingWord
            if !coordinationManager.navigationPathDictionary.isEmpty {
                coordinationManager.navigationPathDictionary.removeLast()
            }
            modelContext.delete(word)
            try? modelContext.save()
            coordinationManager.navigationPathDictionary.append(existingWord)
        }
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

#Preview("Clean environment", traits: .modifier(PreviewHelper())) {
    WordEditView(word: Word.examples[1])
        .environment(CoordinationManager())
}

#Preview("With default language") {
    @Previewable @State var coordinator = CoordinationManager(defaultLanguage: Language.espanol)
    WordEditView(word: Word.examples[0])
        .environment(coordinator)
}
