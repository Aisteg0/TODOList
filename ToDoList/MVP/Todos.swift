//
//  Todos.swift
//  ToDoList
//
//  Created by Михаил Ганин on 30.08.2024.
//

import Foundation
import CoreData

class Todos : Decodable, Identifiable, ObservableObject {
    let id : Int?
    var todo : String?
    var completed : Bool?
    let userId : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case todo = "todo"
        case completed = "completed"
        case userId = "userId"
    }
    
    init(todo: String?, completed: Bool?, id: Int?, userId: Int?) {
        self.todo = todo
        self.completed = completed
        self.userId = userId
        self.id = id
    }
}
