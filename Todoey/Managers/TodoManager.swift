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
    
    private var todoRepository: any Repository<Todo>
    
    init(persistanceService: any Repository<Todo> = TodoRepository()) {
        self.todoRepository = persistanceService
    }

    func fetch() {
        do {
            self.todos = try todoRepository.fetch()
            
            if let sort = UserDefaults.standard.value(forKey: "sortBy") as? String,
               let sortType = SortBy(rawValue: sort) {
                sortBy(sortType)
            }
        } catch {
            print("❌ Error in \(#function) ", error)
        }
    }
    
    func save(title: String, description: String, isDone: Bool = false, isFavorites: Bool = false) {
        let todo = Todo(title: title, description: description, isFavorite: isFavorites)
        
        do {
            try todoRepository.save(item: todo)
            
            self.todos.append(todo)
        } catch {
            print("❌ Error in \(#function) ", error)
        }
    }
    
    func update(todo: Todo, withTitle title: String? = nil, description: String? = nil, isDone: Bool? = nil, isFavorite: Bool? = nil) {

        do {
            let newTodo = Todo(title: title ?? todo.title,
                                   description: description ?? todo.description,
                                   isDone: isDone ?? todo.isDone,
                                   isFavorite: isFavorite ?? todo.isFavorite)
            try todoRepository.update(todo: todo, with: newTodo)
            fetch()
        } catch {
            print("❌ Error in \(#function) ", error)
        }
    }
    
    func delete(_ todo: Todo) {
        do {
            try todoRepository.delete(todo)
            fetch()
        } catch {
            print("❌ Error in \(#function) ", error)
        }
        
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
