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
    @State private var learningEngine = LearningEngine()
    var body: some Scene {
        WindowGroup {
            MainView()
//                .modelContainer(for: [Word.self, WordForm.self], isAutosaveEnabled: true, isUndoEnabled: false)
                .modelContainer(try! PreviewHelper.makeSharedContext())
                .environment(coordinationManager)
                .environment(learningEngine)
        }
    }
}
