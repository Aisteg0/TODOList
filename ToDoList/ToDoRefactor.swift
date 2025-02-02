//
//  ToDoRefactor.swift
//  ToDoList
//
//  Created by Михаил Ганин on 30.08.2024.
//

import SwiftUI
import CoreData

struct ToDoRefactor: View {
    
    @Binding var todoList: Todo
    @Environment(\.editMode) var editMode
    @State private var editedTodoText: String
       @State private var editedTodoCompleted: Bool
    var body: some View {
        Form {
//            Section(header: Text("detail")) {
                if editMode?.wrappedValue == .active {
       
                    TextField("todo", text: $todoList.todo)
                            .font(.title)
                        Toggle("completed", isOn: $todoList.completed)
                            .font(.body)
                            .padding(.top, 8)
                    } else {
                        Text("\($todoList.todo)")
                            .font(.title)
                        HStack {
                            Text("status")
                                .font(.body)
                            Spacer()
                            Image(systemName: todoList.completed ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(todoList.completed ? .green : .red)
                        }
                        .padding(.top, 8)
                    }
                
//            }
        }
        .navigationTitle("details")
        .toolbar {
            EditButton()
        }
    }
}
