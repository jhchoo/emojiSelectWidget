//
//  ContentView.swift
//  emojiSelect
//
//  Created by jae hwan choo on 2021/01/19.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.com.jhchoo.emojiSelect"))
    var emojiData: Data = Data()
    
    // 더미데이터 추가
    let emojis = [
        Emoji(icon: "😍", name: "Happy", description: "이것은 행복을 의미 한다."),
        Emoji(icon: "😐", name: "Stare", description: "이것은 보통 항상 이런 분위기를 유지한다."),
        Emoji(icon: "🤬", name: "Heated", description: "이것은 기분나쁠 때 사용한다."),
    ]
    
    var body: some View {
        VStack(spacing: 30) {
            ForEach(emojis) { emoji in
                EmojiView(emoji: emoji)
                    .onTapGesture {
                        save(emoji)
                    }
            }
        }
    }
    
    func save(_ emoji: Emoji) {
        guard let emojiData = try? JSONEncoder().encode(emoji) else { return }
        self.emojiData = emojiData

        print("save \(emoji)")
        // 위젯 갱신
        WidgetCenter.shared.reloadAllTimelines()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
