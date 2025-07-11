//
//  HomeWorkMainView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 24.06.2025.
//

import SwiftUI

struct HomeWorkMainView: View {
    @Environment(\.modelContext) private var modelContext
//    @Environment(LearningEngine.self) private var learningEngine
    @State private var learningEngine = LearningEngine()

    
    var body: some View {
        Label("Zadanie Domowe", systemImage: "book.pages.fill")
            .font(.title)
            .onAppear{
                learningEngine.gatherStatistics(modelContext: modelContext)
            }
        Button("stats") {
            learningEngine.gatherStatistics(modelContext: modelContext)
        }
        .buttonStyle(.bordered)
        
    }
}

#Preview {
    HomeWorkMainView()
}
