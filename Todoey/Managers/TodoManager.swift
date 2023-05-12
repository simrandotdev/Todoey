//
//  TodoManager.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-12.
//

import Foundation
import SwiftUI

class TodoManager: ObservableObject {
    
    @Published var todos: [Todo] = []

    func fetch() {
        todos = Todo.fetch()
        
        if let sort = UserDefaults.standard.value(forKey: "sortBy") as? String,
           let sortType = SortBy(rawValue: sort) {
            sortBy(sortType)
        }
    }
    
    func save(title: String, description: String, isDone: Bool = false, isFavorites: Bool = false) {
        let todo = Todo(title: title, description: description, isFavorite: isFavorites)
        todo.save()
        todos.append(todo)
    }
    
    func update(todo: Todo, withTitle title: String? = nil, description: String? = nil, isDone: Bool? = nil, isFavorites: Bool? = nil) {
        todo.update(title: title, description: description, isDone: isDone, isFavorite: isFavorites)
        fetch()
    }
    
    func delete(_ todo: Todo) {
        todo.delete()
        fetch()
    }
    
    func sortBy(_ sortType: SortBy) {
        switch sortType {
        case .creation:
            todos = todos.sorted(by: { $0.createdOn > $1.createdOn })
        case .updation:
            todos = todos.sorted(by: { $0.updatedOn > $1.updatedOn })
        case .done:
            todos = todos.sorted(by: { a, b in a.isDone })
        case .favorites:
            todos = todos.sorted(by: { a, b in a.isFavorite })
        }
        
        UserDefaults.standard.set(sortType.rawValue, forKey: "sortBy")
    }
}
