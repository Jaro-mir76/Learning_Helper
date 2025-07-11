//
//  TagPickerView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 08.07.2025.
//

import SwiftUI
import SwiftData

struct TagPickerView: View {
    @Environment(CoordinationManager.self) private var coordinationManager
    @Query private var tags: [Tag]
    @State private var selectedTags: Set<Tag> = []
    @State private var searchText: String = ""
    @State private var createNewTagVisible: Bool = false
    
    var body: some View {
        HStack {
            TextField("search tag", text: $searchText)
            Button("Create tag") {
                createNewTagVisible = true
            }
            .buttonStyle(.bordered)
            .disabled( !searchText.isEmpty && tags.first(where: {$0.tagName == searchText.lowercased()}) == nil ? false : true)
            .popover(isPresented: $createNewTagVisible, attachmentAnchor: .point(.bottom)) {
                CreateNewTagView(tagName: searchText)
                    .presentationCompactAdaptation(.popover)
            }
        }
        HStack {
            Text("Selected tags:")
            Spacer()
            Button("Add selected") {
                
            }
            .buttonStyle(.bordered)
            .disabled(selectedTags.isEmpty ? true : false)
        }
        if !selectedTags.isEmpty {
            ForEach(Array(selectedTags.sorted(by: {$0.tagName < $1.tagName}).enumerated()), id:\.offset ) { index, tag in
                HStack {
                TagView(tag: tag)
                    .onTapGesture {
                        selectedTags.remove(tag)
                    }
                    Spacer()
                }
            }
        } else {
            Text("No selected tags")
        }
        HStack {
            Text("All tags:")
            Spacer()
        }
        TagList(selectedTags: $selectedTags, searchText: searchText.lowercased())
        Spacer()
    }
}

private struct TagList: View {
    @Query private var tags: [Tag]
    @Binding var selectedTags: Set<Tag>
//    @State private var createNewTag: Bool = false
    var searchText: String
    
    init(selectedTags: Binding<Set<Tag>>, searchText: String) {
        self._selectedTags = selectedTags
        self.searchText = searchText
        if searchText.count > 0 {
            let fetchDescriptor = FetchDescriptor<Tag>(predicate: #Predicate{$0.tagName.contains(searchText)}, sortBy: [SortDescriptor(\.tagName)])
            self._tags = Query(fetchDescriptor, animation: .default)
        }
    }
    
    var body: some View {
        if !tags.isEmpty {
            ForEach(tags) { tag in
                if !selectedTags.contains(tag) {
                    HStack {
                        TagView(tag: tag)
                            .onTapGesture {
                                selectedTags.insert(tag)
                            }
                        Spacer()
                    }
                }
            }
        } else {
            Text("No tags found")
        }
    }
}

#Preview(traits: .modifier(PreviewHelper())) {
    TagPickerView()
        .environment(CoordinationManager())
}
