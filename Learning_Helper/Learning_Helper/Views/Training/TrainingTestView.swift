//
//  TestView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 12.07.2025.
//

import SwiftUI

struct TrainingTestView: View {
    @Environment(LearningEngine.self) private var learningEngine
    var taskIndex: Int
    @State private var answer: String = ""
    @State private var correctAnswer: String = ""
    @State private var passed: Bool? = nil
    @FocusState private var answerFieldFocused: Bool

    var body: some View {
        Text(learningEngine.testContent[taskIndex].taskType.niceName)
            .font(.title3)
            .padding(.vertical, 30)
            .padding(.horizontal, 10)
            .foregroundStyle(.white)
        VStack(alignment: .center) {
            Text(learningEngine.testContent[taskIndex].question)
                .font(.title3)
                .frame(maxWidth: .infinity, minHeight: 50)
                .padding(.horizontal, 20)
//                .background(.white)
                .boxView(frame: .white, background: .white, opacity: 1)
                
                .padding(.vertical, 20)
                
            if learningEngine.testContent[taskIndex].question2 != nil {
                Text(learningEngine.testContent[taskIndex].question2!)
                    .font(.title3)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .boxView(frame: .white, background: .white, opacity: 1)
//                    .background(.white)
                    .padding(.vertical, 10)
            }
            Spacer()
        }
        .frame(minHeight: 200,maxHeight: 300 , alignment: .center)
//        .background(.teal)
        
        VStack {
            TextField("Your Answer", text: $answer, axis: .vertical)
                .font(.title3)
                .padding(10)
                .boxView(frame: .white, background: .white, opacity: 1)
                .focused($answerFieldFocused)
                .task {
                    answerFieldFocused = true
                }
//                .background(.white)

            if passed == nil {
                Spacer()
                Button {
                    (passed, correctAnswer) = learningEngine.checkTaskAnswerAndRecordResult(answer: [answer])
                } label: {
                    Text("Check answer")
                        .labelStyle(.titleOnly)
                        .font(.title3)
                        .padding(20)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 70)
            } else {
                if passed == true {
                    Text(correctAnswer)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .boxView(frame: .white, background: .white, opacity: 1)
//                        .background(.white)
                    
                }else if passed == false {
                    Text(correctAnswer)
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .boxView(frame: .white, background: .white, opacity: 1)
//                        .background(.white)

                }
                Spacer()
                Button {
                    passed = nil
                    answer = ""
                    correctAnswer = ""
                    learningEngine.initiateTask()
                } label: {
                    Text("Continue")
                        .labelStyle(.titleOnly)
                        .font(.title3)
                        .padding(20)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(minHeight: 50, maxHeight: 300)
//        .background(.yellow)
        Spacer()
    }
}

#Preview {
    @Previewable @State var learningEngine = LearningEngine(previewOnly: true, activeTaskIndex: 0)
    TrainingTestView(taskIndex: 0)
        .environment(learningEngine)

}
