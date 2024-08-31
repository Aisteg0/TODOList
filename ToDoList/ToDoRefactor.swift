//
//  ToDoRefactor.swift
//  ToDoList
//
//  Created by Михаил Ганин on 30.08.2024.
//

import SwiftUI
import CoreData

struct ToDoRefactor: View {
    
    @ObservedObject var todo: Todos
    @State private var text: String = ""
    @State private var completed: Bool = false
    @Environment (\.editMode) var editMode
    @Environment (\.managedObjectContext) var viewContext
    
    init(todo: Todos) {
        _todo = ObservedObject(initialValue: todo)
        _text = State(initialValue: todo.todo ?? "")
        _completed = State(initialValue: todo.completed ?? false)
    }
    
    var body: some View {
        Form {
            Section(header: Text("detail")) {
                if editMode?.wrappedValue == .active {
                    TextField("todo", text: $text)
                        .font(.title)
                    Toggle("completed", isOn: $completed)
                        .font(.body)
                        .padding(.top, 8)
                } else {
                    Text(text)
                        .font(.title)
                    HStack {
                        Text("status")
                            .font(.body)
                        Spacer()
                        Image(systemName: completed ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(completed ? .green : .red)
                    }
                    .padding(.top, 8)
                }
            }
        }
        .navigationTitle("details")
        .toolbar {
            EditButton()
        }
        .onChange(of: editMode?.wrappedValue) { newValue in
            if newValue == .inactive {
                save()
            }
        }
    }
    
    private func save() {
        todo.todo = text
        todo.completed = completed
        try? viewContext.save()
    }
}
