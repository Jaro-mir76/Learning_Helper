//
//  ContentView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import SwiftUI

struct MainView: View {
    @Environment(CoordinationManager.self) private var coordinationManager
    
    var body: some View {
            @Bindable var coordinator = coordinationManager
            TabView(selection: $coordinator.activeTab) {
                Tab(value: 1) {
                    TrainingMainView()
                } label: {
                    Label("Trening", systemImage: "brain.head.profile")
//                        .labelStyle(.titleOnly)
                }
                Tab(value: 2) {
                    HomeWorkMainView()

                } label: {
                    Label("Zadanie domowe", systemImage: "book.pages.fill")
//                        .labelStyle(.titleOnly)
                }
                .badge(Text("\(coordinationManager.navigationPathDictionary.isEmpty ? "empty" : "not empty")"))
                Tab(value: 3) {
                    DictionaryMainView()

                } label: {
                    Label("Twój słownik", systemImage: "text.book.closed.fill")
//                        .labelStyle(.titleOnly)
                }
                .badge(coordinationManager.navigationPathDictionary.count)
            }

//            .tabViewStyle(.automatic)
    }
}

#Preview {
    MainView()
        .environment(CoordinationManager())
        .environment(LearningEngine())
}

#Preview("With some words", traits: .modifier(PreviewHelper())) {
    MainView()
        .environment(CoordinationManager())
        .environment(LearningEngine())
}
