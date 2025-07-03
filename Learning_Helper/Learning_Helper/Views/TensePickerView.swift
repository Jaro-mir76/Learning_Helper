//
//  TensePickerView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 27.06.2025.
//

import SwiftUI
import SwiftData

struct TensePickerView: View {
    @Environment(CoordinationManager.self) private var coordinationManager
    @Binding var tense: Tense?
    
    var body: some View {
        HStack{
            Text("Tense")
            Spacer()
            NavigationLink(destination: TenseListView (tense: $tense), label: {
                Spacer()
                Text("\(tense == nil ? "You need to choose tense." : tense!.name )")
                    .foregroundStyle(tense == nil ? .red : .blue)
            })
        }
        .onAppear {
//                addDefaultTense()
        }
    }
    
    private func addDefaultTense() {
        if tense == nil, coordinationManager.defaultTense != nil {
                tense = coordinationManager.defaultTense
        }
    }
}

private struct TenseListView: View {
    @Environment(CoordinationManager.self) private var coordinationManager
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Tense.name)]) private var tenses: [Tense]
    @State private var newTenseName: String = ""
    @Binding var tense: Tense?
    
    var body: some View {
        List {
            ForEach (tenses) { t in
                HStack {
                    Text(t.name)
                    Spacer()
                    if t == self.tense {
                        Label("Selected", systemImage: "checkmark")
                            .foregroundStyle(.blue)
                            .font(.title3)
                            .labelStyle(.iconOnly)
                    }
                }
                .onTapGesture {
                    tense = t
                    coordinationManager.defaultTense = t
                }
            }
            HStack {
                TextField("Add tense", text: $newTenseName)
                Button(action: {
                    withAnimation {
                        addTense()
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .accessibilityLabel("Add tense")
                }
                .disabled(newTenseName.isEmpty)
            }
        }
    }
    
    private func addTense() {
        if newTenseName != "", tenses.first(where: {$0.name == newTenseName}) == nil {
            let newTense = Tense(name: newTenseName, tenseDescription: "")
            modelContext.insert(newTense)
            try? modelContext.save()
            let newT = tenses.first(where: {$0.name == newTenseName})
            if let newT {
                tense = newT
                coordinationManager.defaultTense = newT
            }
            newTenseName = ""
        }
    }
}

#Preview("Tenses list", traits: .modifier(PreviewHelper())) {
    @Previewable @State var tense: Tense? = Tense.presente
    TenseListView(tense: $tense)
        .environment(CoordinationManager())
}

#Preview("There are tenses", traits: .modifier(PreviewHelper())) {
    @Previewable @State var tense: Tense? = Tense.presente
    TensePickerView(tense: $tense)
        .environment(CoordinationManager())
}

#Preview("No defined tenses") {
    TensePickerView(tense: .constant(nil))
        .environment(CoordinationManager())
}
