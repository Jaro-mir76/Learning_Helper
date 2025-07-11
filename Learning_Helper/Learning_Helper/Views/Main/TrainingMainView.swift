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
    @State private var answer: String = ""
    @State private var correctAnswer: String = ""
    @State private var passed: Bool? = nil
    
    var body: some View {
        VStack {
            Label("Training", systemImage: "brain.head.profile")
                .labelStyle(.titleOnly)
                .font(.title)
                .onAppear{
                    learningEngine.gatherStatistics(modelContext: modelContext)
                }
            if learningEngine.testContent.isEmpty {
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
                .buttonStyle(.bordered)
                Spacer()
            } else if let taskIndex = learningEngine.activeTaskIndex{
                Text(learningEngine.testContent[taskIndex].taskType.niceName)
                    .font(.title3)
                    .padding(30)
                VStack(alignment: .center) {
                    Text(learningEngine.testContent[taskIndex].question)
                        .font(.title2)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .padding(.horizontal, 20)
                        .boxView()
                        .padding(.vertical, 20)
                    if learningEngine.testContent[taskIndex].question2 != nil {
                        Text(learningEngine.testContent[taskIndex].question2!)
                            .font(.title2)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .boxView()
                            .padding(.vertical, 10)
                    }
                    Spacer()
                }
                .frame(minHeight: 200,maxHeight: 300 , alignment: .center)
                TextField("Your Answer", text: $answer, axis: .vertical)
                    .font(.title3)
                    .padding(10)
                    .boxView()
                VStack {
                    if passed == nil {
                        Spacer()
                            Button {
                                (passed, correctAnswer) = learningEngine.checkTaskAnswer(answer: [answer])
                            } label: {
                                Label("Check answer", systemImage: "")
                                    .labelStyle(.titleOnly)
                                    .font(.title2)
                                    .padding(20)
                            }
                            .buttonStyle(.bordered)
                            .padding(.top, 70)
                    } else {
                            if passed == true {
                                Text("Hurrreeeyyyy!")
                                    .font(.title3)
                                    .padding(10)
                                    .boxView()
                                
                            }else if passed == false {
                                Text(correctAnswer)
                                    .font(.title3)
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .boxView()
                            }
                            Spacer()
                            Button {
                                passed = nil
                                answer = ""
                                correctAnswer = ""
                                learningEngine.initiateTask()
                            } label: {
                                Label("Continue", systemImage: "")
                                    .labelStyle(.titleOnly)
                                    .font(.title2)
                                    .padding(20)
                            }
                            .buttonStyle(.bordered)
                    }
                }
                .frame(minHeight: 50, maxHeight: 200)
                Spacer()
            } else {
                Spacer()
                Text("Good job, todays training is finished!")
                    .font(.title3)
                    .padding(20)
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
                .buttonStyle(.bordered)
                Spacer()
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
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
