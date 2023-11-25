//
//  EcoPlay_ios_frontApp.swift
//  EcoPlay_ios_front
//
//  Created by Zeddin Dhia on 25/11/2023.
//

import SwiftUI

@main
struct EcoPlay_ios_frontApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
