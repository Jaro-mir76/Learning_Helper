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
    @Binding var showExample: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
        Text("Tense: \(wordForm.tense?.name ?? "")")
            .font(.footnote)
            .padding(EdgeInsets(top: 5, leading: 0, bottom: -5, trailing: 0))
            
//            .padding(.leading, 4)
            HStack(alignment: .center) {
                
                VStack(alignment: .leading) {
                    
                    Text(wordForm.name)
                        .textCase(.uppercase).bold()
                    Text(wordForm.meanings.map({$0.meaning}).joined(separator: ", "))
//                        .padding(.leading, 10)
                }
                Spacer()
                Button {
                    coordinationManager.navigationPathDictionary.append(wordForm)
                } label: {
                    Label("Edit", systemImage: "pencil")
                        .labelStyle(.iconOnly)
                }
                .buttonStyle(.bordered)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .boxView()
            if showExample, !wordForm.usageExamples.isEmpty {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Usage examples")
                            .font(.footnote)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: -5, trailing: 0))
                        ForEach(wordForm.usageExamples, id: \.id) { example in
                            Divider()
                            VStack(alignment: .leading) {
                                Text(example.sentence)
                                Text(example.meaning)
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
//        HStack {
//            Text(wordForm.meanings.map({$0.meaning}).joined(separator: ", "))
//            Spacer()
//        }
        
    }
}

#Preview {
    WordFormView(wordForm: Word.examples[1].forms[0], showExample: .constant(true))
        .environment(CoordinationManager())
}

private struct wordFormListView: View {
    var wordForm: WordForm
    var body: some View {
        
    }
}
