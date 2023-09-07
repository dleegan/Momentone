//
//  MomentoneApp.swift
//  Momentone
//
//  Created by dleegan on 07/09/2023.
//

import SwiftUI

@main
struct MomentoneApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationTitle("Text")
            }
        }
    }
}
