//
//  TODOView.swift
//  ToDoList
//
//  Created by Михаил Ганин on 30.08.2024.
//

import SwiftUI
import CoreData

struct TODOView: View {
    
    @ObservedObject var todoList: TodoList
    
    var body: some View {
        NavigationStack  {
            VStack {
                List {
                    ForEach(todoList.items) { todo in
                        HStack {
                            //                            NavigationLink(destination: ToDoRefactor(todoList: todo)) {
                            HStack {
                                Text(todo.todo)
                                Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(todo.completed ? .green : .red)
                                //                                                    }
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem {
                        NavigationLink(destination: AddToDo(todoList: todoList)) {
                            Image(systemName: "plus")
                        }
                    }
                }
                
                .navigationTitle("TODOList")
            }
        }
        .onAppear() {
            if todoList.items.isEmpty {
                map()
            }
        }
    }
    
    
    private func map() {
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
                            let newTodo = Todo(context: todoList.viewContext)
                            newTodo.todo = todo.todo ?? ""
                            newTodo.completed = todo.completed ?? false
                            newTodo.id = Int64(todo.id ?? 0)
                            newTodo.userId = Int64(todo.userId ?? 0)
                        }
                        do {
                            try todoList.viewContext.save()
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
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { todoList.items[$0] }.forEach(todoList.viewContext.delete)
            do {
                try todoList.viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

