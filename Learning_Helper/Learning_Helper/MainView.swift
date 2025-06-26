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
        NavigationStack {
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
                Tab(value: 3) {
                    DictionaryMainView()

                } label: {
                    Label("Twój słownik", systemImage: "text.book.closed.fill")
//                        .labelStyle(.titleOnly)
                }
            }
//            .tabViewStyle(.automatic)
        }
    }
}

#Preview {
    MainView()
        .environment(CoordinationManager())
}

#Preview("With some words", traits: .modifier(PreviewHelper())) {
    MainView()
        .environment(CoordinationManager())
}
