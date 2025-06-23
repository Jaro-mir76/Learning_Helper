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
                    Label("Trenuj", systemImage: "brain.head.profile")
                        .font(.title)
                } label: {
                    Label("Trening", systemImage: "brain.head.profile")
//                        .labelStyle(.titleOnly)
                }
                Tab(value: 2) {
                    Label("Zadanie Domowe", systemImage: "book.pages.fill")
                        .font(.title)

                } label: {
                    Label("Zadanie domowe", systemImage: "book.pages.fill")
//                        .labelStyle(.titleOnly)
                }
                Tab(value: 3) {
                    Label("Twój słownik", systemImage: "text.book.closed.fill")
                        .font(.title)

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
