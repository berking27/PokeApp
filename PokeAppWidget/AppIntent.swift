//
//  AppIntent.swift
//  PokeAppWidget
//
//  Created by Berkin Demirel on 3.12.2024.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }


}
