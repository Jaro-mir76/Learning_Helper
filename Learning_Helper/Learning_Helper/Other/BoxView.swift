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
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 5, style: .continuous).stroke(.gray, lineWidth: 1, antialiased: true)
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(Color.gray).opacity(0.1)
                }
            )
//            .frame(height: 30)
        
//            .background(Color.gray.opacity(0.1))
//            .background(in: RoundedRectangle(cornerRadius: 7, style: .continuous))
//            .background()
////            .border(.gray)
//            
//            .compositingGroup()
//            .shadow(radius: 2)
    }
}

extension View {
    func boxView() -> some View {
        modifier(BoxView())
    }
}
