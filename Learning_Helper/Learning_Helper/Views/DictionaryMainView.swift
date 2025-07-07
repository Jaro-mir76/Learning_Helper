//
//  DictionaryMainView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 24.06.2025.
//

import SwiftUI
import SwiftData

struct DictionaryMainView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(CoordinationManager.self) private var coordinationManager
    @Query(sort: \Word.name, order: .forward) private var words: [Word]
    
//    @State private var showEditView: Bool = false
//    @State private var addNewWord: Bool = false
//    @State private var newWord: Word = Word(name: "")
    
    var body: some View {
        @Bindable var coordinationManager = coordinationManager
        NavigationStack(path: $coordinationManager.navigationPathDictionary) {
            VStack {
                Label("Twój słownik", systemImage: "text.book.closed.fill")
                    .font(.title)
                List {
                    ForEach(words, id: \.id) { word in
                        WordCardView(word: word)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button{
                                    editWord(word)
                                }label: {
                                    Label("Edit word", systemImage: "pencil")
                                        .labelStyle(.iconOnly)
                                }
                                .tint(.green)
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                Button {
                                    deleteWord(word)
                                } label: {
                                    Label("Delete word", systemImage: "x.circle.fill")
                                        .labelStyle(.iconOnly)
                                }
                                .tint(.red)
                            }
                    }
                }
                Spacer()
            }
            .navigationDestination(for: Word.self) { word in
                WordEditView(word: word)
            }
            .navigationDestination(for: WordForm.self) { wordForm in
                WordFormEditView(wordForm: wordForm)
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button {
                        addWord()
                    } label: {
                        Label("Add word", systemImage: "plus")
                    }
                }
            }
            .task {
                if words.isEmpty {
                    Word.examples.forEach { word in
                        modelContext.insert(word)
                    }
                }
            }
        }
    }
    
    private func editWord(_ word: Word) {
        coordinationManager.selectedWord = word
//        var wordCopy = Word(name: "")
//        wordCopy.copy(word)
        coordinationManager.navigationPathDictionary.append(word)
    }
    
    private func deleteWord(_ word: Word) {
        modelContext.delete(word)
        try? modelContext.save()
    }
    
    private func addWord() {
        let newWord = Word(name: "")
//        modelContext.insert(newWord)
        coordinationManager.navigationPathDictionary.append(newWord)
    }
}

#Preview("Empty") {
    DictionaryMainView()
        .environment(CoordinationManager())
}

#Preview("With some words", traits: .modifier(PreviewHelper())) {
    DictionaryMainView()
        .environment(CoordinationManager())
}
