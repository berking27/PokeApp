//
//  PokeAppWidgetBundle.swift
//  PokeAppWidget
//
//  Created by Berkin Demirel on 3.12.2024.
//

import WidgetKit
import SwiftUI

@main
struct PokeAppWidgetBundle: WidgetBundle {
    var body: some Widget {
        PokeAppWidget()
        PokeAppWidgetControl()
        PokeAppWidgetLiveActivity()
    }
}
