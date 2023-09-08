//
//  MomentoneApp.swift
//  Momentone
//
//  Created by dleegan on 07/09/2023.
//

import SwiftUI

@main
struct MomentoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
