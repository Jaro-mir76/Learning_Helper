//
//  LanguagePickerView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 26.06.2025.
//

import SwiftUI
import SwiftData

struct LanguagePickerView: View {
    @Environment(CoordinationManager.self) private var coordinationManager
    @Binding var language: Language?
    
    var body: some View {
        HStack{
            Text("Language")
            Spacer()
            NavigationLink(destination: LanguageList(language: $language), label: {
                Spacer()
                Text("\(language == nil ? "You need to choose language." : language!.name )")
                    .foregroundStyle(language == nil ? .red : .blue)
            })
        }
        .onAppear {
//                addDefaultLanguage()
        }
    }
    
    private func addDefaultLanguage() {
        if language == nil, coordinationManager.defaultLanguage != nil {
                language = coordinationManager.defaultLanguage
        }
    }
}

private struct LanguageList: View {
    @Environment(CoordinationManager.self) private var coordinationManager
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Language.name)]) private var languages: [Language]
    @State private var newLanguageName: String = ""
    @Binding var language: Language?
    
    var body: some View {
        List {
            ForEach (languages) { lang in
                HStack {
                    Text(lang.name)
                    Spacer()
                    if lang == language {
                        Label("Selected", systemImage: "checkmark")
                            .foregroundStyle(.blue)
                            .font(.title3)
                            .labelStyle(.iconOnly)
                    }
                }
                .onTapGesture {
                    language = lang
                    coordinationManager.defaultLanguage = lang
                }
            }
            HStack {
                TextField("Add language", text: $newLanguageName)
                Button(action: {
                    withAnimation {
                        addLanguage()
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .accessibilityLabel("Add note")
                }
                .disabled(newLanguageName.isEmpty)
            }
        }
    }
    
    private func addLanguage() {
        if newLanguageName != "", languages.first(where: {$0.name == newLanguageName}) == nil {
            let newLanguage = Language(name: newLanguageName)
            modelContext.insert(newLanguage)
            try? modelContext.save()
            let newL = languages.first(where: {$0.name == newLanguageName})
            if let newL {
                language = newL
                coordinationManager.defaultLanguage = newL
            }
            newLanguageName = ""
        }
    }
}

#Preview("LanguageTool", traits: .modifier(PreviewHelper())) {
    @Previewable @State var language: Language? = Language.espanol
    LanguageList(language: $language)
        .environment(CoordinationManager())
}

#Preview("There are langueages", traits: .modifier(PreviewHelper())) {
    @Previewable @State var language: Language? = Language.espanol
    LanguagePickerView(language: $language)
        .environment(CoordinationManager())
}

#Preview("No defined languages") {
    LanguagePickerView(language: .constant(nil))
        .environment(CoordinationManager())
}
