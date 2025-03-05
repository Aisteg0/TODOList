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
    @ObservedObject var presenter: TodoPresenter
    @State private var newTodo: String = ""
    @State private var isCompleted: Bool = false
    
    var body: some View {
        Form {
            TextField("New Todo", text: $newTodo)
            Toggle("Completed", isOn: $isCompleted)
            Button("Add Todo") {
                presenter.addTodo(todo: newTodo, completed: isCompleted, userId: 1)
                newTodo = ""
                isCompleted = false
                dismiss()
            }
        }
        .navigationTitle("Add Todo")
    }
}
