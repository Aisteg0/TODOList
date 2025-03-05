//
//  TodosItem.swift
//  ToDoList
//
//  Created by Михаил Ганин on 30.08.2024.
//

import Foundation

struct TodosItem : Decodable {
    let todos : [Todos]?
    let total : Int?
    let skip : Int?
    let limit : Int?

    enum CodingKeys: String, CodingKey {
        case todos = "todos"
        case total = "total"
        case skip = "skip"
        case limit = "limit"
    }
}
