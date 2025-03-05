//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Михаил Ганин on 30.08.2024.
//

import SwiftUI

@main
struct ToDoListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            let presenter = TodoPresenter(context: persistenceController.container.viewContext)
            TODOView(presenter: presenter)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
