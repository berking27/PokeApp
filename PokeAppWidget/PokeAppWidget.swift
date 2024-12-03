//
//  PokeAppWidget.swift
//  PokeAppWidget
//
//  Created by Berkin Demirel on 3.12.2024.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: AppIntentTimelineProvider {
    var randomPokemon: Pokemon {
        let context = PersistenceController.shared.container.viewContext
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        
        var results: [Pokemon] = []
        
        do {
            results = try context.fetch(fetchRequest)
        } catch {
            print("Couldn't fetch Pokemon \(error.localizedDescription)")
        }
        
        if let randomPokemon = results.randomElement() {
            return randomPokemon
        }
        
        return SamplePokemon.samplePokemon
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), pokemon: SamplePokemon.samplePokemon)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), pokemon: randomPokemon)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, pokemon: randomPokemon)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let pokemon: Pokemon
}

struct PokeAppWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetSize
    var entry: Provider.Entry

    var body: some View {
        switch widgetSize {
        case .systemSmall:
            WidgetPokemonView(widgetSize: .small)
                .environmentObject(entry.pokemon)
        case .systemMedium:
            WidgetPokemonView(widgetSize: .medium)
                .environmentObject(entry.pokemon)
        case .systemLarge:
            WidgetPokemonView(widgetSize: .large)
                .environmentObject(entry.pokemon)
        default:
            WidgetPokemonView(widgetSize: .large)
                .environmentObject(entry.pokemon)
        }
    }
}

struct PokeAppWidget: Widget {
    let kind: String = "PokeAppWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            PokeAppWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }.contentMarginsDisabled()
    }
}

//extension ConfigurationAppIntent {
//    fileprivate static var smiley: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "😀"
//        return intent
//    }
//    
//    fileprivate static var starEyes: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "🤩"
//        return intent
//    }
//}

#Preview(as: .systemSmall) {
    PokeAppWidget()
} timeline: {
    SimpleEntry(date: .now, pokemon: SamplePokemon.samplePokemon)
    SimpleEntry(date: .now, pokemon: SamplePokemon.samplePokemon)
}
