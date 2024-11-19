//
//  CatsApp.swift
//  Cats
//
//  Created by federico piccirilli on 19/11/2024.
//

import SwiftUI

@main
struct CatsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
