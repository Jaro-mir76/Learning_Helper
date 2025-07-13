//
//  BoxView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 05.07.2025.
//

import SwiftUI

struct BoxView: ViewModifier {
    var frame: Color = .gray
    var background: Color = .white
    var opacity: Double = 0.2
    
    @ViewBuilder @MainActor @preconcurrency func body(content: Self.Content) -> some View {
        content
            .padding(4)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 5, style: .continuous).stroke(frame, lineWidth: 1, antialiased: true)
                    RoundedRectangle(cornerRadius: 5, style: .continuous).fill(background).opacity(opacity)
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
    
    func boxView(frame: Color) -> some View {
        modifier(BoxView(frame: frame))
    }
    
    func boxView(background: Color) -> some View {
        modifier(BoxView(background: background))
    }
    
    func boxView(frame: Color, background: Color) -> some View {
        modifier(BoxView(frame: frame, background: background))
    }
    
    func boxView(frame: Color, background: Color, opacity: Double) -> some View {
        modifier(BoxView(frame: frame, background: background, opacity: opacity))
    }
}
