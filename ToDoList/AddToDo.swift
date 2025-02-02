//
//  AddToDo.swift
//  ToDoList
//
//  Created by Михаил Ганин on 30.08.2024.
//

import SwiftUI
import CoreData

struct AddToDo: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var todoList: TodoList
    @State private var newTodoText: String = ""
    @State private var newTodoCompleted: Bool = false
    
    var body: some View {
        Form {
            TextField("NewTodo", text: $newTodoText)
            Button(action: {
                todoList.addTodo(todoText: newTodoText, completed: newTodoCompleted, id: 0, userId: 0)
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
}
