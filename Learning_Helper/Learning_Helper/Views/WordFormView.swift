//
//  WordFormView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 01.07.2025.
//

import SwiftUI

struct WordFormView: View {
    @Environment(CoordinationManager.self) private var coordinationManager
    @State private var editMode: Bool = false
    var wordForm: WordForm
    
    var body: some View {
//        Button {
//            editMode.toggle()
//        } label: {
//            Label(editMode ? "View mode" : "Edit mode", systemImage: "pencil")
//                .labelStyle(.titleOnly)
//        }
//        if editMode {
//            WordFormEditView(wordForm: wordForm)
//        } else {
//        NavigationLink(destination: WordFormEditView(wordForm: wordForm)) {
//            Label("Edit", systemImage: "pencil")
//                .labelStyle(.titleOnly)
//        }
//        NavigationLink(value: wordForm) {
//            Label("Edit", systemImage: "pencil")
//                .labelStyle(.titleOnly)
//        }
        Button {
            coordinationManager.navigationPathDictionary.append(wordForm)
        } label: {
            Label("Edit", systemImage: "pencil")
                .labelStyle(.titleOnly)
        }
        .buttonStyle(.bordered)

        Section{
            HStack {
                Text("Name:")
                Spacer()
                Text(wordForm.name)
            }
            HStack {
                Text("Meannings:")
                Spacer()
                Text(wordForm.meanings.map({$0.meaning}).joined(separator: ", "))
            }
        } header: {
            Text("Tense: \(wordForm.tense?.name ?? "")")
        }
        Section(header: Text("Usage examples")) {
            ForEach(wordForm.usageExamples, id: \.id) { example in
                VStack(alignment: .leading) {
                    Text(example.sentence)
                    Text(example.meaning)
                }
            }
        }
//        }
    }
}

#Preview {
    WordFormView(wordForm: Word.examples[1].forms[0])
        .environment(CoordinationManager())
}
