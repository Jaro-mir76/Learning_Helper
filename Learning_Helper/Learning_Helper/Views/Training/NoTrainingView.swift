//
//  NoTrainingView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 12.07.2025.
//

import SwiftUI

struct NoTrainingView: View {
    @Environment(LearningEngine.self) private var learningEngine
    
    var body: some View {
        Spacer()
        Text("Lets practice a little!")
            .font(.title)
            .padding(20)
//            .boxView(background: .yellow)
            .foregroundStyle(.white)
        Spacer()
        Spacer()
        Button {
            learningEngine.startLearning(numberOfTasks: 5)
        } label: {
            Label("Start", systemImage: "brain.head.profile")
                .labelStyle(.titleOnly)
                .font(.largeTitle)
                .padding(20)
        }
        .buttonStyle(.borderedProminent)
        Spacer()
    }
}

#Preview {
    NoTrainingView()
        .environment(LearningEngine())
}
