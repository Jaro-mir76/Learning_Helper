//
//  BoxView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 05.07.2025.
//

import SwiftUI

struct BoxView: ViewModifier {
    
    @ViewBuilder @MainActor @preconcurrency func body(content: Self.Content) -> some View {
        content
            .padding(4)
            .frame(height: 30)
            .background(Color.white.opacity(0.1))
            .background(in: RoundedRectangle(cornerRadius: 7, style: .continuous))
            .compositingGroup()
//            .shadow(radius: 2)
    }
}

extension ViewModifier {
//    func boxView() -> some ViewModifier {
//        return BoxView()
//    }
}
