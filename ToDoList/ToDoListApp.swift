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
            let todoList = TodoList(viewContext: persistenceController.container.viewContext)
            TODOView(todoList: todoList)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
