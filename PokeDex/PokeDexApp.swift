//
//  PokeDexApp.swift
//  PokeDex
//
//  Created by Aakash Ambodkar
//

import SwiftUI
import SwiftData

@main
struct PokeDexApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Pokemon.self,
        ])
        let modelconfiguration = ModelConfiguration(schema: schema,
            isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations:
                                        [modelconfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)
        }
    }
}
