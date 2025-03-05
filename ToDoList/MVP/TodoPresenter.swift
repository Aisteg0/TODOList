//
//  TodoPresenter.swift
//  ToDoList
//
//  Created by Михаил Ганин on 03.03.2025.
//

import Foundation
import CoreData

class TodoPresenter: ObservableObject {
    @Published var todos: [Todo] = []
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchTodos() {
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        
        do {
            todos = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch todos: \(error)")
        }
    }
    
    func addTodo(todo: String, completed: Bool, userId: Int64) {
        let newTodo = Todo(context: context)
        newTodo.todo = todo
        newTodo.completed = completed
        newTodo.userId = userId
        newTodo.id = Int64(todos.count + 1)
        
        do {
            try context.save()
            fetchTodos()
        } catch {
            print("Failed to save todo: \(error)")
        }
    }
    
    func deleteTodo(at offsets: IndexSet) {
        offsets.forEach { index in
            let todo = todos[index]
            context.delete(todo)
        }
        
        do {
            try context.save()
            fetchTodos()
        } catch {
            print("Failed to delete todo: \(error)")
        }
    }
    
    func mapTodosFromAPI() {
        guard let url = URL(string: "https://dummyjson.com/todos") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            let jsonDecoder = JSONDecoder()
            
            do {
                let response = try jsonDecoder.decode(TodosItem.self, from: data)
                
                if let todos = response.todos {
                    DispatchQueue.main.async {
                        for todo in todos {
                            let newTodo = Todo(context: self.context)
                            newTodo.todo = todo.todo ?? ""
                            newTodo.completed = todo.completed ?? false
                            newTodo.id = Int64(todo.id ?? 0)
                            newTodo.userId = Int64(todo.userId ?? 0)
                        }
                        do {
                            try self.context.save()
                            self.fetchTodos()
                        } catch {
                            print("Ошибка сохранения: \(error.localizedDescription)")
                        }
                    }
                }
            } catch {
                print("Ошибка декодирования: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
