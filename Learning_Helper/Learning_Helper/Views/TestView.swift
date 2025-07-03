//
//  TestView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 02.07.2025.
//

import SwiftUI

struct TestView: View {
    @Bindable var word: Word
    var body: some View {
        Text("Hello, here is \(word.name)")
    }
}

#Preview {
    TestView(word: Word.examples[0])
}
