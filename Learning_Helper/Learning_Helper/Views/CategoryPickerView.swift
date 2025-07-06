//
//  CategoryPickerView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 27.06.2025.
//

import SwiftUI
import SwiftData

struct CategoryPickerView: View {
    @Environment(CoordinationManager.self) private var coordinationManager
    @Binding var category: Category?
    
    var body: some View {
        HStack{
//            Text("Category")
//            Spacer()
            NavigationLink(destination: CategoryListView (category: $category), label: {
//                Spacer()
                Text("\(category == nil ? "choose category" : category!.name )")
                    .foregroundStyle(category == nil ? .red : .blue)
                    .font(.callout)
            })
        }
        .onAppear {
                addDefaultLanguage()
        }
    }
    
    private func addDefaultLanguage() {
        if category == nil, coordinationManager.defaultCategory != nil {
                category = coordinationManager.defaultCategory
        }
    }
}

private struct CategoryListView: View {
    @Environment(CoordinationManager.self) private var coordinationManager
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\Category.name)]) private var categories: [Category]
    @State private var newCategoryName: String = ""
    @Binding var category: Category?
    
    var body: some View {
        List {
            ForEach (categories) { cat in
                HStack {
                    Text(cat.name)
                    Spacer()
                    if cat == category {
                        Label("Selected", systemImage: "checkmark")
                            .foregroundStyle(.blue)
                            .font(.title3)
                            .labelStyle(.iconOnly)
                    }
                }
                .onTapGesture {
                    category = cat
                    coordinationManager.defaultCategory = cat
                }
            }
            HStack {
                TextField("Add category", text: $newCategoryName)
                Button(action: {
                    withAnimation {
                        addCategory()
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .accessibilityLabel("Add category")
                }
                .disabled(newCategoryName.isEmpty)
            }
        }
    }
    
    private func addCategory() {
        if newCategoryName != "", categories.first(where: {$0.name == newCategoryName}) == nil {
            let newCategory = Category(name: newCategoryName, categoryDescription: "")
            modelContext.insert(newCategory)
            try? modelContext.save()
            let newCat = categories.first(where: {$0.name == newCategoryName})
            if let newCat {
                category = newCat
                coordinationManager.defaultCategory = newCat
            }
            newCategoryName = ""
        }
    }
}

#Preview("Category list", traits: .modifier(PreviewHelper())) {
    @Previewable @State var category: Category? = Category.myWords
    CategoryListView(category: $category)
        .environment(CoordinationManager())
}

#Preview("There are categories", traits: .modifier(PreviewHelper())) {
    @Previewable @State var category: Category? = Category.myWords
    CategoryPickerView(category: $category)
        .environment(CoordinationManager())
}

#Preview("No defined categories") {
    CategoryPickerView(category: .constant(nil))
        .environment(CoordinationManager())
}
