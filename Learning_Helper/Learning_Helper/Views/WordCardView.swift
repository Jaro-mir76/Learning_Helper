//
//  WordCardView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 25.06.2025.
//

import SwiftUI

struct WordCardView: View {
    @State private var showExamples: Bool = false
    var word: Word
    
    var body: some View {
        VStack {
            HStack {
                WordLabelView(word: word.name)
                Spacer()
                Button {
                    withAnimation {
                        showExamples.toggle()
                    }
                } label: {
                    Text(showExamples ? "Hide examples." : "Show examples.")
                }
            }
            ForEach(word.forms, id: \.id) { form in
                HStack {
                    Text("\(form.name): ")
                        .font(.headline)
                    Text(labelFor(form.meanings.map({ $0.meaning })))
                    Spacer()
                }
                if showExamples {
                    ForEach(form.usageExamples, id: \.id) { example in
                        VStack {
                            Text(example.sentence)
                            Text(example.meaning)
                        }
                    }
                }
            }
        }
        .padding(5)
    }
    
    private func labelFor (_ meanings: [String]) -> String {
        var result = ""
        let numberOfMeanings = meanings.count
        for (n, meaning) in meanings.enumerated() {
            result += meaning
            if n < numberOfMeanings - 1 {
                result += ", "
            }
        }
        return result
    }
}

#Preview {
    WordCardView(word: Word.examples[0])
}
