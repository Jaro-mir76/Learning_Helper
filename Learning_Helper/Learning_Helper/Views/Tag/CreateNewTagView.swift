//
//  CreateNewTagView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 09.07.2025.
//

import SwiftUI

struct CreateNewTagView: View {
    var tagName: String
    @State private var selectedColor: ColorData = .blue
    @State private var selectedIcon: String = Tag.tagIconsList[0]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            TagView(tag: Tag(tagName: tagName, tagIcon: selectedIcon, tagColor: selectedColor))
            HStack {
                Text("Color")
                Picker("Colors", selection: $selectedColor) {
                    ForEach(ColorData.allCases, id: \.self) { color in
                        Rectangle().fill(color.color)
                            .frame(width: 50, height: 25)
                    }
                }
                .pickerStyle(.wheel)
                
                Text("Icon")
                Picker("Icons", selection: $selectedIcon) {
                    ForEach(Tag.tagIconsList, id: \.self) { icon in
                        Label("", systemImage: icon)
                            .foregroundStyle(selectedColor.color)
                    }
                }
                .pickerStyle(.wheel)
            }
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .buttonStyle(.bordered)
                Button("Save") {
                    modelContext.insert(Tag(tagName: tagName.lowercased(), tagIcon: selectedIcon, tagColor: selectedColor))
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}

#Preview {
    CreateNewTagView(tagName: "#tag")
}
