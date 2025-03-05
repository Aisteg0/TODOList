//
//  TODOView.swift
//  ToDoList
//
//  Created by Михаил Ганин on 30.08.2024.
//

import SwiftUI
import CoreData

struct TODOView: View {
    @ObservedObject var presenter: TodoPresenter
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(presenter.todos, id: \.id) { todo in
                        HStack {
                            Text(todo.todo)
                            Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(todo.completed ? .green : .red)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem {
                        NavigationLink(destination: AddToDo(presenter: presenter)) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .navigationTitle("TODOList")
            }
        }
        .onAppear() {
            if presenter.todos.isEmpty {
                presenter.mapTodosFromAPI()
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        presenter.deleteTodo(at: offsets)
    }
}
