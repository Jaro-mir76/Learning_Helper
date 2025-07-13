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
//    @State private var learningEngine = LearningEngine()
    @Environment(LearningEngine.self) private var learningEngine
    
    var body: some View {
        VStack {
            Label("Training", systemImage: "brain.head.profile")
                .labelStyle(.titleOnly)
                .font(.title)
                .foregroundStyle(.white)
                .onAppear{
                    learningEngine.gatherStatistics(modelContext: modelContext)
                }
            if learningEngine.testContent.isEmpty {
                NoTrainingView()
            } else if let taskIndex = learningEngine.activeTaskIndex{
                TrainingTestView(taskIndex: taskIndex)
            } else {
                TrainingFinishedView()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.green)
        .background(ignoresSafeAreaEdges: .all)
    }
}

#Preview {
    TrainingMainView()
        .environment(CoordinationManager())
        .environment(LearningEngine())
}

#Preview("Training", traits: .modifier(PreviewHelper())) {
    @Previewable @State var learningEngine = LearningEngine(previewOnly: true, activeTaskIndex: 0)
    TrainingMainView()
        .environment(CoordinationManager())
        .environment(learningEngine)
}

#Preview("Training done", traits: .modifier(PreviewHelper())) {
    @Previewable @State var learningEngine = LearningEngine(previewOnly: true, activeTaskIndex: nil)
    TrainingMainView()
        .environment(CoordinationManager())
        .environment(learningEngine)
}
