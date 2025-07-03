//
//  Learning_HelperApp.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import SwiftUI
import SwiftData

@main
struct Learning_HelperApp: App {
    @State private var coordinationManager = CoordinationManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: [Word.self, WordForm.self], isAutosaveEnabled: true, isUndoEnabled: false)
//                .modelContainer(for: [
//                    Word.self,
//                    WordForm.self
//                ])
                .environment(coordinationManager)
        }
    }
}
