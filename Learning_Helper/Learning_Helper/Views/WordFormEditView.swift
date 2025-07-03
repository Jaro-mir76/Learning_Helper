//
//  WordFormEditView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 01.07.2025.
//

import SwiftUI

struct WordFormEditView: View {
    @Environment(CoordinationManager.self) private var coordinationManager
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Bindable var wordForm: WordForm
    
    @State private var newMeaning: String = ""
    @State private var newUsageExampleSentence: String = ""
    @State private var newUsageExampleMeaning: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Word")) {
                TextField("word", text: $wordForm.name )
                TensePickerView(tense: $wordForm.tense)
            }
            Section(header: Text("Meanings")) {
                ForEach (wordForm.meanings, id:\.id) { meaning in
                    @Bindable var meaning = meaning
                    TextField("meaning", text: $meaning.meaning)
                }
                HStack {
                    TextField("add meaning", text: $newMeaning)
                    Button(action: {
                        withAnimation {
                            addMeaning()
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add tense")
                    }
                    .disabled(newMeaning.isEmpty)
                }
            }
            Section(header: Text("Usage examples")) {
                ForEach(wordForm.usageExamples, id: \.id) { example in
                    @Bindable var example = example
                    VStack(alignment: .leading) {
                        TextField("sentence", text: $example.sentence)
                        TextField("meaning", text: $example.meaning)
                    }
                }
            }
            TextField("usage examples - sentence", text: $newUsageExampleSentence)
            HStack {
                TextField("usage examples - meaning", text: $newUsageExampleMeaning)
                Button(action: {
                    withAnimation {
                        addExample()
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .accessibilityLabel("Add example")
                }
                .disabled(newUsageExampleMeaning.isEmpty || newUsageExampleSentence.isEmpty)
            }
        }
//        .navigationBarBackButtonHidden()
        .toolbar {
//            ToolbarItem(placement: .cancellationAction) {
//                Button {
//                    try? modelContext.save()
////                    modelContext.rollback()
//                    dismiss()
//                } label: {
//                    Label("Back", systemImage: "lessthan")
//                }
//            }
//            ToolbarItem(placement: .confirmationAction) {
//                Button {
//                    try? modelContext.save()
//                    dismiss()
//                } label: {
//                    Text("Save")
//                }
//            }
        }
    }
    
    private func addMeaning() {
        wordForm.meanings.append(Meaning(meaning: newMeaning))
        newMeaning = ""
    }
    
    private func addExample() {
        wordForm.usageExamples.append(UsageExample(sentence: newUsageExampleSentence, meaning: newUsageExampleMeaning, exampleStatus: StatusCode.new))
        newUsageExampleSentence = ""
        newUsageExampleMeaning = ""
    }
}

#Preview {
    WordFormEditView(wordForm: Word.examples[1].forms[0])
        .environment(CoordinationManager())
}
