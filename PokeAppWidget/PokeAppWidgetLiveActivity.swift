//
//  PokeAppWidgetLiveActivity.swift
//  PokeAppWidget
//
//  Created by Berkin Demirel on 3.12.2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct PokeAppWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct PokeAppWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: PokeAppWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension PokeAppWidgetAttributes {
    fileprivate static var preview: PokeAppWidgetAttributes {
        PokeAppWidgetAttributes(name: "World")
    }
}

extension PokeAppWidgetAttributes.ContentState {
    fileprivate static var smiley: PokeAppWidgetAttributes.ContentState {
        PokeAppWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: PokeAppWidgetAttributes.ContentState {
         PokeAppWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: PokeAppWidgetAttributes.preview) {
   PokeAppWidgetLiveActivity()
} contentStates: {
    PokeAppWidgetAttributes.ContentState.smiley
    PokeAppWidgetAttributes.ContentState.starEyes
}
