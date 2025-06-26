//
//  WordLabelView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 25.06.2025.
//

import SwiftUI

struct WordLabelView: View {
    var word: String
    
    var body: some View {
        Text(word)
            .font(.title3)
            .textCase(.uppercase)
            .padding(.horizontal, 10)
            .background(
                ZStack {
                    Capsule(style: .circular).stroke(.blue, lineWidth: 3, antialiased: true)
                    Capsule().fill(Color.green).opacity(0.5)
                        .shadow(color: .gray, radius: 2, x: 1, y: 2)
                }
            )
    }
}

#Preview {
    WordLabelView(word: "Hello")
}
