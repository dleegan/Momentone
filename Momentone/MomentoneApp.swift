//
//  MomentoneApp.swift
//  Momentone
//
//  Created by dleegan on 07/09/2023.
//

import SwiftUI
import SwiftData

@main
struct MomentoneApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Note.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: Note.self, inMemory: true)
        }
//        .modelContainer(sharedModelContainer)
    }
}
