//
//  LearningEngine.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 25.06.2025.
//

import Foundation
import SwiftData

@Observable
class LearningEngine {
    var statistics: [LearningStatistics]
    var testContent: [TestTask]
    var activeTaskIndex: Int?
    private var wordForms: [WordForm]
    let wordMask = "_______"   // "#wordMask#"
    private let problematicCharacters = ["łl", "Łl"]
    
    init(statistics: [LearningStatistics] = [], testContent: [TestTask] = [], activeTaskIndex: Int? = nil, wordForms: [WordForm] = []) {
        self.statistics = statistics
        self.testContent = testContent
        self.activeTaskIndex = activeTaskIndex
        self.wordForms = wordForms
    }
    
//    used only for preview purposes
    init(previewOnly: Bool, activeTaskIndex: Int? = nil) {
        self.statistics = []
        let testTask = TestTask(wordId: UUID(), taskType: .translateWordToNative, question: "tener", question2: "Pytanie pomocnicze", answers: ["mieć"], passed: nil)
        let testTask2 = TestTask(wordId: UUID(), taskType: .translateWordToNative, question: "tener", question2: nil, answers: ["mieć"], passed: nil)
        self.testContent = [testTask, testTask2]
        self.activeTaskIndex = activeTaskIndex
        self.wordForms = []
    }
    
    func gatherStatistics(modelContext: ModelContext) {
        self.statistics = []
        var fetchDescriptor = FetchDescriptor<WordForm>(sortBy: [SortDescriptor(\.progressIndicator, order: .forward)])
        fetchDescriptor.fetchLimit = 10
        if let wordFormstmp = try? modelContext.fetch(fetchDescriptor) {
            self.wordForms = wordFormstmp
        } else {
            print ("Something is wrong - was not able to fetch word forms!")
            return
        }

        for wForm in wordForms {
            print("wordForm: \(wForm.name) id: \(wForm.id)")
            let stats = LearningStatistics(wordFormID: wForm.id, counterTests: wForm.counterTest, counterSuccess: wForm.counterTestSuccess, progressIndicator: wForm.progressIndicator, lastTestDate: wForm.lastTestDate)
            self.statistics.append(stats)
        }
        print ("statistics gathered, elements no. \(self.statistics.count)")
        print ("index \t\t success \t\t test count \t\t progress indicator \t\t last test date")
        if statistics.count > 0 {
            for i in 0...statistics.count - 1 {
                print ("\(i) \t\t \(statistics[i].counterSuccess) \t\t \(statistics[i].counterTests) \t\t \(statistics[i].progressIndicator) \t\t \(statistics[i].lastTestDate?.description ?? "n/a")")
                if !self.wordForms.isEmpty, let wform = wordForms.first(where: {$0.id == statistics[i].wordFormID}) {
                    print(wform.name)
                }
            }
        }
    }
    
    func defineTestContent(numberOfTasks: Int) {
        var maxTestElements = numberOfTasks
        self.testContent = []
        if self.statistics.count < numberOfTasks {
            if self.statistics.count > 1 {
                maxTestElements = self.statistics.count - 1
            }else {
                return
            }
        }
        print ("statistics.coutn: \(self.statistics.count)")
        print ("maxTestElements: \(maxTestElements)")
        var wordForm: WordForm
        var wordId: UUID
        var taskType: TaskType
        var question: String
        var question2: String? = nil
        var answers: [String]
        
        for i in 0...maxTestElements {
            wordId = self.statistics[i].wordFormID
            wordForm = self.wordForms.first(where: {$0.id == wordId})!
            if wordHasExamples(wordForm: wordForm) {
//  Randomly choose task type from all available
                taskType = TaskType(rawValue: Int.random(in: 0..<5))!
            } else {
//  Randomly choose task type only from first 2: "translate Word to Native" or "Translate Word to Foreign"
                taskType = TaskType(rawValue: Int.random(in: 0..<2))!
            }
            
            switch taskType {
            case .translateWordToNative:
                (question, answers) = testTranslateWordToNative(wordForm: wordForm)
            case .translateWordToForeign:
                (question, answers) = testTranslateWordToForeign(wordForm: wordForm)
            case .translateSentenceToNative:
                (question, answers) = translateSentenceToNative(wordForm: wordForm)
            case .translateSentenceToForeign:
                (question, answers) = translateSentenceToForeign(wordForm: wordForm)
            case .fillGapInForeignSentence:
                (question, question2, answers) = fillGapInForeignSentence(wordForm: wordForm)
            }
            
            self.testContent.append(TestTask(wordId: wordId, taskType: taskType, question: question, question2: question2, answers: answers))
            print("added to test tasks: \(taskType) Q: \(question) Q2: \(question2 ?? "") A: \(answers)")
            question2 = nil
        }
        print ("test content table contains \(self.testContent.count) elements")
    }
    
    func activeLearningSession() -> Bool {
        return !testContent.isEmpty
    }
    
    func startLearning(numberOfTasks: Int = 5) {
        if self.testContent.isEmpty {
            defineTestContent(numberOfTasks: numberOfTasks)
        }
        initiateTask()
    }
    
    func initiateTask() {
        if let taskIndex = testContent.firstIndex(where: {$0.passed == nil}){
            self.activeTaskIndex = taskIndex
//            print ("new task index is \(taskIndex)")
        } else if let taskIndex = testContent.firstIndex(where: {$0.passed == false}){
            self.activeTaskIndex = taskIndex
//            print ("new task index is \(taskIndex)")
        } else {
            self.activeTaskIndex = nil
        }
    }
    
    func checkTaskAnswerAndRecordResult(answer: [String]) -> (Bool, String) {
        //        if self.testContent[activeTaskIndex!].answers.first?.lowercased() == answer.first?.lowercased() {
        //        if self.testContent[activeTaskIndex!].answers.first?.compare(answer.first!, options: [.caseInsensitive, .diacriticInsensitive]) == .orderedSame {
        //            wordForms.first(where: {$0.id ==  testContent[activeTaskIndex!].wordId})?.recordSuccess()
        //            self.testContent[self.activeTaskIndex!].passed = true
        //            return (true, "Correct answer!")
        //        } else {
        //            wordForms.first(where: {$0.id ==  testContent[activeTaskIndex!].wordId})?.recordFailure()
        //            self.testContent[self.activeTaskIndex!].passed = false
        //            return (false , "Wrong answer, correct is \(self.testContent[activeTaskIndex!].answers.first!)")
        //        }
        
//        print ("provided answer is \(answer.first!)")
        //        print ("expected answer is \(self.testContent[activeTaskIndex!].answers.first!)")
        
        var response = ""
        //        let regex = try! Regex("[^\\s]\\w*")
        //        Removing here unnecessary white spaces on the beginning and end of the answer
        //        let answer = String(answer.first![answer.first!.firstMatch(of: regex)!.range])
        let regexRemovePunctuation = try! Regex("[.,;:]")
        var answer = String(answer.first!.replacing(regexRemovePunctuation, with: ""))
        //        print ("provided answer is (after regexRemovePunctuation) \(answer)")
        
        let regexRemoveSpaces = try! Regex("\\s+")
        answer = String(answer.replacing(regexRemoveSpaces, with: " "))
        //        print ("provided answer is (after regexRemoveSpaces) \(answer)")
        
        let regex = try! Regex("[^\\s][\\s\\w']*[^\\W]")
        answer = String(answer[answer.firstMatch(of: regex)!.range])
        //        print ("provided answer is (after regex) \(answer)")
        
        guard var expectedAnswer = self.testContent[activeTaskIndex!].answers.first else {return (false, "No expected answer")}
        expectedAnswer = String(expectedAnswer[expectedAnswer.firstMatch(of: regex)!.range])
//        print ("expected answer is (after regex) \(expectedAnswer)")
        
//        if let expectedAnswer = self.testContent[activeTaskIndex!].answers.first,  expectedAnswer.compare(answer, options: .caseInsensitive) == .orderedSame {
//
        if expectedAnswer.compare(answer, options: .caseInsensitive) == .orderedSame {
//            print ("recording success")
            recordTaskResult(success: true)
            return (true, "Correct answer!")
        } else {
//            flatAnswer -> answer where "problematic characters" like ł are replaced with characters (without diacritic)
            var flatAnswer = answer
//            let normalizedActiveTaskAnswer = self.testContent[activeTaskIndex!].answers.first!
//            let expectedAnswer = expectedAnswer
//            var normalizedActiveTaskAnswerL2 = self.testContent[activeTaskIndex!].answers.first!
            var flatExpectedAnswer = expectedAnswer
            
//            In this part I use 'problematicCharacters' array to replace in user answer and expected answer problematic characters which are not managed properly by .diacriticInsensitive by compare
            for characters in self.problematicCharacters {
                let c1 = String(characters[characters.startIndex])
                let c2 = String(characters[characters.index(before: characters.endIndex)])
                flatAnswer = flatAnswer.replacingOccurrences(of: c1, with: c2)
                flatExpectedAnswer = flatExpectedAnswer.replacingOccurrences(of: c1, with: c2)
            }
            if flatAnswer.compare(flatExpectedAnswer, options: [.caseInsensitive, .diacriticInsensitive]) == .orderedSame {
                response = "Pay attention to details!\n"
                var flatAnswerIndex = flatAnswer.startIndex
                for expectedAnswerIndex in expectedAnswer.indices {
                    if String(flatAnswer[flatAnswerIndex]).compare(String(expectedAnswer[expectedAnswerIndex]), options: .caseInsensitive) != .orderedSame  {
                        response += ">" + String(expectedAnswer[expectedAnswerIndex]) + "<"
                    } else {
                        response += String(expectedAnswer[expectedAnswerIndex])
                    }
                    flatAnswerIndex = flatAnswer.index(after: flatAnswerIndex)
                    if flatAnswerIndex > flatAnswer.endIndex {
                        recordTaskResult(success: false)
                        return (false , "Wrong answer, correct is \(self.testContent[activeTaskIndex!].answers.first!)")
                    }
                }
//                response += "\n"
//                flatAnswerIndex = flatAnswer.startIndex
//                for expectedAnswerIndex in expectedAnswer.indices {
//                    if String(flatAnswer[flatAnswerIndex]).compare(String(expectedAnswer[expectedAnswerIndex]), options: .caseInsensitive) != .orderedSame {
//                        response += ">" + String(expectedAnswer[expectedAnswerIndex]) + "<"
//                    } else {
//                        response += String(expectedAnswer[expectedAnswerIndex])
//                    }
//                    flatAnswerIndex = flatAnswer.index(after: flatAnswerIndex)
//                    if flatAnswerIndex > flatAnswer.endIndex {
//                        print ("recording failure")
//                        recordTaskResult(success: false)
//                        return (false , "Wrong answer, correct is \(self.testContent[activeTaskIndex!].answers.first!)")
//                    }
//                }
//                print ("recording success with remarks")
                recordTaskResult(success: true)
                return (true, response)
            } else {
//                print ("recording failure")
                recordTaskResult(success: false)
                return (false , "Wrong answer, correct is \(self.testContent[activeTaskIndex!].answers.first!)")
            }
        }
    }
    
    private func recordTaskResult(success: Bool) {
        if success {
            wordForms.first(where: {$0.id ==  testContent[activeTaskIndex!].wordId})?.recordSuccess()
            self.testContent[self.activeTaskIndex!].passed = true
        } else {
            wordForms.first(where: {$0.id ==  testContent[activeTaskIndex!].wordId})?.recordFailure()
            self.testContent[self.activeTaskIndex!].passed = false
        }
    }
    
    func testTranslateWordToNative(wordForm: WordForm) -> (String, [String]) {
        let question = wordForm.name
        let answers = wordForm.meanings.map({$0.meaning})
        return (question, answers)
    }
    
    func testTranslateWordToForeign(wordForm: WordForm) -> (String, [String]) {
        let question = wordForm.meanings.map({$0.meaning}).randomElement()
        let answer = wordForm.name
        return (question!, [answer])
    }
    
    func translateSentenceToNative(wordForm: WordForm) -> (String, [String]) {
        let usageExample = wordForm.usageExamples.randomElement()
            return (usageExample?.sentence ?? "", [usageExample?.meaning ?? ""])
    }
    
    func translateSentenceToForeign(wordForm: WordForm) -> (String, [String]) {
        let usageExample = wordForm.usageExamples.randomElement()
            return (usageExample?.meaning ?? "", [usageExample?.sentence ?? ""])
    }
    
    func fillGapInForeignSentence(wordForm: WordForm) -> (String, String, [String]) {
        let usageExample = wordForm.usageExamples.randomElement()
        let question = usageExample?.meaning ?? ""
        let question2 = hideWordInSentence(wordForm: wordForm.name, sentence: usageExample?.sentence ?? "")
        let answers = findWordFormInSentence(wordForm: wordForm.name, sentence: usageExample?.sentence ?? "")
            return (question, question2, answers)
    }
    
    func wordHasExamples(wordForm: WordForm) -> Bool {
        if !wordForm.usageExamples.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    func hideWordInSentence(wordForm: String, sentence: String) -> String {
        let regex = try! Regex(wordForm + "[a-z]*")
        var sentenceWithoutWordForm = sentence.replacing(regex, with: self.wordMask)
        if sentenceWithoutWordForm == sentence {
            sentenceWithoutWordForm = sentence.lowercased().replacing(regex, with: self.wordMask)
        }
        return sentenceWithoutWordForm
    }
    
    func findWordFormInSentence(wordForm: String, sentence: String) -> [String] {
        let regex = try! Regex(wordForm + "[a-z]*")
        var answers: [String] = []
        let foundMatches = sentence.lowercased().matches(of: regex)
//        print ("sentence (lowercased): \(sentence.lowercased())")
        for match in foundMatches {
            answers.append(String(sentence.lowercased()[match.range]))
//            print ("answers: \(answers)")
        }
        return answers
    }
}
