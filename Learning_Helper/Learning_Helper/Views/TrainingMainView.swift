//
//  TrainingMainView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 24.06.2025.
//

import SwiftUI
import SwiftData

struct TrainingMainView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var learningEngine = LearningEngine()
    
    var body: some View {
        VStack {
            Label("Trenuj", systemImage: "brain.head.profile")
                .font(.title)
            Button("Sprawdź") {
                learningEngine.gatherStatistics(modelContext: modelContext)
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    TrainingMainView()
}
