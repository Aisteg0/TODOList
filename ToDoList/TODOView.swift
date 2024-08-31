//
//  TODOView.swift
//  ToDoList
//
//  Created by Михаил Ганин on 30.08.2024.
//

import SwiftUI
import CoreData

struct TODOView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    let persistenceController = PersistenceController.shared
    @State private var todos: [Todos] = []
    @State private var isMapCalled = false
    
    var body: some View {
        NavigationStack  {
            VStack {
                List {
                    ForEach(todos) { todo in
                        HStack {
                            NavigationLink(destination: ToDoRefactor(todo: todo)) {
                                Text(todo.todo ?? "")
                                Image(systemName: todo.completed ?? false ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(todo.completed ?? false ? .green : .red)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem {
                        NavigationLink(destination: AddToDo(todos: $todos)) {
                            Image(systemName: "plus")
                        }
                    }
                }
                
                .navigationTitle("TODOList")
            }
        }
        .onAppear() {
            if !isMapCalled {
                map()
                isMapCalled = true
            }
        }
    }
    
    private func map() {
        let url = URL(string: "https://dummyjson.com/todos")
        guard let url else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else { return }
            let jsonDecoder = JSONDecoder()
            let response = try? jsonDecoder.decode(TodosItem.self, from: data)
            guard let response else { return }
            DispatchQueue.main.async {
                self.todos = response.todos ?? []
            }
        }
        task.resume()
    }
    
    private func saveToDo() {
        let viewContext = persistenceController.container.viewContext
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        let fetchedTodos = try! viewContext.fetch(fetchRequest)
        let newTodo = fetchedTodos.map { Todos(todo: $0.todo, completed: $0.completed, id: 0, userId: 0) }
        self.todos.append(contentsOf: newTodo)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach { todo in
                if let index = todos.firstIndex(where: { $0.id == todo.id }) {
                    todos.remove(at: index)
                }
            }
        }
    }
}

#Preview {
    TODOView()
}
