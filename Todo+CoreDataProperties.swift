//
//  Todo+CoreDataProperties.swift
//  ToDoList
//
//  Created by Михаил Ганин on 31.08.2024.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var completed: Bool
    @NSManaged public var todo: String?
    @NSManaged public var id: Int64
    @NSManaged public var userId: Int64

}

extension Todo : Identifiable {

}
