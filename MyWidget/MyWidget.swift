//
//  MyWidget.swift
//  MyWidget
//
//  Created by jae hwan choo on 2021/01/19.
//

import WidgetKit
import SwiftUI

struct EmojiEnty: TimelineEntry {
    let date = Date()
    let emoji: Emoji
}

struct Provider: TimelineProvider {
    // 기본형을 만들고 지워도 동작한다. =_=
    // typealias Entry = EmojiEnty
    
    @AppStorage("emoji", store: UserDefaults(suiteName: "group.com.jhchoo.emojiSelect"))
    var emojiData: Data = Data()
    
    // 위젯을 만들기 위해 생성하는 생성하기 전 보여주는 화면의 데이터
    func placeholder(in context: Context) -> EmojiEnty {
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData) else { return EmojiEnty(emoji: Emoji()) }
        let entry = EmojiEnty(emoji: emoji)
        return entry
    }
    
    // 빠른 렌더링을 위한 데이터
    func getSnapshot(in context: Context, completion: @escaping (EmojiEnty) -> Void) {
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData) else { return }
        let entry = EmojiEnty(emoji: emoji)
        completion(entry)
    }
    
    // 시간별 뷰 업데이트 일정시간마다 업데이트 요청 가능
    func getTimeline(in context: Context, completion: @escaping (Timeline<EmojiEnty>) -> Void) {
        guard let emoji = try? JSONDecoder().decode(Emoji.self, from: emojiData) else { return }
        
        let entry = EmojiEnty(emoji: emoji)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
}

struct WidgetEntryView: View {
    let entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        
        switch family {
        case .systemSmall:
            EmojiView(emoji: entry.emoji)
        case .systemMedium:
            HStack(spacing: 30, content: {
                EmojiView(emoji: entry.emoji)
                Text(entry.emoji.name)
                    .font(.largeTitle)
            })
        default:
            VStack(alignment: .center, spacing: 30, content: {
                HStack(spacing: 30, content: {
                    EmojiView(emoji: entry.emoji)
                    Text(entry.emoji.name)
                        .font(.largeTitle)
                })
                Text(entry.emoji.description)
                    .font(.title)
                    .padding()
            })
        }
        
    }
}

@main
struct MyWidget: Widget {
    private let kind = "My_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { (entry) in
            WidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
