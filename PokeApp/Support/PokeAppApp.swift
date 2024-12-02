//
//  PokeAppApp.swift
//  PokeApp
//
//  Created by Berkin Demirel on 1.12.2024.
//

import SwiftUI

@main
struct PokeAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
