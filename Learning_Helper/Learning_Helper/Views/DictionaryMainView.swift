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
    @Query(sort: \Word.name) private var words: [Word]
//    @State private var showEditView: Bool = false
    
    var body: some View {
        @Bindable var coordinationManager = coordinationManager
        
        NavigationStack(path: $coordinationManager.navigationPathDictionary) {
            Label("Twój słownik", systemImage: "text.book.closed.fill")
                .font(.title)
            LazyVStack {
                ForEach(words, id: \.id) { word in
                    WordCardView(word: word)
                }
            }
            Spacer()
            .task {
                if words.isEmpty {
                    Word.examples.forEach { word in
                        modelContext.insert(word)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    NavigationLink(destination: WordEditView(word: nil)) {
                        Label("Add word", systemImage: "plus")
                    }
//                    Button {
////                        showEditView.toggle()
//                        
//                    } label: {
//                        Label("Add word", systemImage: "plus")
//                    }
                }
            }
//            .sheet(isPresented: $showEditView) {
//                WordEditView(word: coordinationManager.selectedWord)
//            }
            .navigationDestination(for: Word.self) { word in
                WordEditView(word: coordinationManager.selectedWord)
            }
        }
    }
}

#Preview("Empty") {
    DictionaryMainView()
        .environment(CoordinationManager())
}

#Preview("With some words", traits: .modifier(PreviewHelper()), body: {
    DictionaryMainView()
        .environment(CoordinationManager())
})
