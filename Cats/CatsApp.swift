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
          ContentView(viewModel: CatViewModel(catManager: CatManager(networkClient: CatNetworkService(), databaseClient: CoredataService())))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
