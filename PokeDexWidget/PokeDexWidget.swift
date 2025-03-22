//
//  PokeDexWidget.swift
//  PokeDexWidget
//
//  Created by Aakash Ambodkar
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry.placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry.placeholder
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry.placeholder
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    // Build Model here..
    let date: Date
    let name: String
    let types: [String]
    let sprite: Image
    
    static var placeholder: SimpleEntry {
        SimpleEntry(date: .now,
                    name: "bulbasaur",
                    types: ["grass", "poison"],
                    sprite: Image(.bulbasaur))
    }
    static var placeholder2: SimpleEntry {
        SimpleEntry(date: .now,
                    name: "mew",
                    types: ["psychic"],
                    sprite: Image(.mew))
    }
}

struct PokeDexWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            entry.sprite
        }
    }
}

struct PokeDexWidget: Widget {
    let kind: String = "PokeDexWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                PokeDexWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                PokeDexWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    PokeDexWidget()
} timeline: {
    SimpleEntry.placeholder
    SimpleEntry.placeholder2
}
