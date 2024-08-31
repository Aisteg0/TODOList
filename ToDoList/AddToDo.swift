//
//  AddToDo.swift
//  ToDoList
//
//  Created by Михаил Ганин on 30.08.2024.
//

import SwiftUI
import CoreData

struct AddToDo: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Todo.completed, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Todo>
    @Environment (\.dismiss) var dismiss
    @Binding var todos: [Todos]
    
    @State private var newTodoText: String = ""
    @State private var newTodoCompleted: Bool = false
    
    var body: some View {
        Form {
            TextField("NewTodo", text: $newTodoText)
            Button(action: {
                saveTodo()
                dismiss()
            }, label: {
                Text("SaveTodo")
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(BorderlessButtonStyle())
            .padding()
        }
        .navigationTitle("AddTodo")
    }
    
    private func saveTodo() {
        let newTodo = Todo(context: viewContext)
        newTodo.todo = newTodoText
        newTodo.completed = newTodoCompleted
        newTodo.id = 0
        newTodo.userId = 0
        try? viewContext.save()
        DispatchQueue.main.async {
            let newTodoItem = Todos(todo: newTodoText, completed: newTodoCompleted, id: 0, userId: 0)
            todos.append(newTodoItem)
        }
    }
}
