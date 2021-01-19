//
//  EmojiView.swift
//  emojiSelect
//
//  Created by jae hwan choo on 2021/01/19.
//

import SwiftUI

struct EmojiView: View {
    
    let emoji: Emoji

    var body: some View {
        Text(emoji.icon)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Circle())
    }
}
