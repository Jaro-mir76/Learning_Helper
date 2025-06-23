//
//  Learning_HelperApp.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 20.06.2025.
//

import SwiftUI

@main
struct Learning_HelperApp: App {
    @State private var coordinationManager = CoordinationManager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(coordinationManager)
        }
    }
}
