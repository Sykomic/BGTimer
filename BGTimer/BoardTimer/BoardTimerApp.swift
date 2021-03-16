//
//  BoardTimerApp.swift
//  BoardTimer
//
//  Created by Bigluck on 2021/01/18.
//

import SwiftUI

@main
struct BoardTimerApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
