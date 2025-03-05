//
//  ToDoRefactor.swift
//  ToDoList
//
//  Created by Михаил Ганин on 30.08.2024.
//

import SwiftUI
import CoreData

struct ToDoRefactor: View {
    @ObservedObject var presenter: TodoPresenter
    @Environment(\.editMode) var editMode
    @State private var editedTodoText: String
    @State private var editedTodoCompleted: Bool
    
    var todo: Todo
    
    var body: some View {
        Form {
            if editMode?.wrappedValue == .active {
                TextField("todo", text: $editedTodoText)
                    .font(.title)
                Toggle("completed", isOn: $editedTodoCompleted)
                    .font(.body)
                    .padding(.top, 8)
            } else {
                Text(todo.todo)
                    .font(.title)
                HStack {
                    Text("status")
                        .font(.body)
                    Spacer()
                    Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(todo.completed ? .green : .red)
                }
                .padding(.top, 8)
            }
        }
        .navigationTitle("details")
        .toolbar {
            EditButton()
        }
    }
}
