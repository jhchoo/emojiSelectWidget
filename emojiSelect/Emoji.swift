//
//  Emoji.swift
//  emojiSelect
//
//  Created by jae hwan choo on 2021/01/19.
//

import Foundation

// Indentifiable프로토콜은 식별 가능하게 하는 프로토콜
// 이 프로토콜은 5.1에 구현되었다고 합니다.
// 구조체는 id를 통해 각 카드를 식별할 수 있게 됩니다.

struct Emoji: Identifiable, Codable {
    let icon: String
    let name: String
    let description: String
    
    var id: String { icon } // 식별자.
    
    init() {
        icon = "😶"
        name = "N/A"
        description = "N/A"
    }
    
    init(icon: String, name: String, description: String) {
        self.icon = icon
        self.name = name
        self.description = description
    }
}
