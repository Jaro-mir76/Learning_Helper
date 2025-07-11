//
//  TagView.swift
//  Learning_Helper
//
//  Created by Jaromir Jagieluk on 08.07.2025.
//

import SwiftUI

struct TagView: View {
    var tag: Tag
    
    var body: some View {
//        Initial tag style
//        HStack {
//            Label("", systemImage: tag.tagIcon)
//                .labelStyle(.iconOnly)
//            Text(tag.tagName)
//        }
//        .foregroundStyle(tag.tagColor.color)
//        .boxView(frame: tag.tagColor.color, background: Color.white)
        
//        Real ;-) tag style
        HStack {
            Label("", systemImage: "circle")
                .labelStyle(.iconOnly)
                .foregroundStyle(.black)
                .padding(.trailing, -5)
                .padding(.leading, -4)
                .padding(.top, -3)
                .font(.caption2)
            Label("", systemImage: tag.tagIcon)
                .labelStyle(.iconOnly)
                .foregroundStyle(tag.tagColor.color)
            Text(tag.tagName)
                .foregroundStyle(tag.tagColor.color)
        }
        .padding(4)
        .padding(.horizontal, 3)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(tag.tagColor.color, lineWidth: 1, antialiased: true)
                RoundedRectangle(cornerRadius: 5, style: .continuous).fill(.white).opacity(0.2)
            }
        )
    }
}

#Preview {
    TagView(tag: Tag.tagExample)
}
