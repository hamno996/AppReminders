//
//  ReminderAppApp.swift
//  ReminderApp
//
//  Created by Hamno Muhsin on 2/25/26.
//

import SwiftUI
import CoreData

@main
struct ReminderAppApp: App {
    var body: some Scene {
        WindowGroup {
           HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
