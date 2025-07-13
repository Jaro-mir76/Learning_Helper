//
//  TrainingFinishedView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 12.07.2025.
//

import SwiftUI

struct TrainingFinishedView: View {
    @Environment(LearningEngine.self) private var learningEngine

    var body: some View {
        Spacer()
        Text("Good job!")
            .font(.title)
            .padding(20)
//            .boxView(background: .yellow)
            .foregroundStyle(.white)
        Spacer()
        Spacer()
        Button {
            learningEngine.testContent = []
        } label: {
            Label("OK", systemImage: "brain.head.profile")
                .labelStyle(.titleOnly)
                .font(.largeTitle)
                .padding(20)
        }
        .buttonStyle(.borderedProminent)
        Spacer()
    }
}

#Preview {
    TrainingFinishedView()
        .environment(LearningEngine())

}
