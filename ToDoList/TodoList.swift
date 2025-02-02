//
//  TodoList.swift
//  ToDoList
//
//  Created by Михаил Ганин on 01.02.2025.
//

import Foundation
import CoreData

class TodoList: ObservableObject {
    @Published var items: [Todo] = []
    
    var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        fetchTodos()
    }
    
    private func fetchTodos() {
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Todo.completed, ascending: true)]
        
        do {
            items = try viewContext.fetch(request)
        } catch {
            print("Error fetching todos: \(error)")
        }
    }
    
    func addTodo(todoText: String, completed: Bool, id: Int, userId: Int) {
        let newTodo = Todo(context: viewContext)
        newTodo.todo = todoText
        newTodo.completed = completed
        newTodo.id = Int64.random(in: 1...10000)
        newTodo.userId = Int64.random(in: 1...10000)
        
        do {
            try viewContext.save()
            fetchTodos()
        } catch {
            print("Error saving new todo: \(error)")
        }
    }
}
