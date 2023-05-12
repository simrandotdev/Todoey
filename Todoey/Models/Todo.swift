//
//  Todo.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import Foundation

struct Todo: Identifiable, Codable, Equatable, Hashable {
    var id: String
    var title: String
    var description: String
    var isDone: Bool
    var isFavorite: Bool
    var createdOn: Date
    var updatedOn: Date
    
    
    
    init(title: String, description: String, isDone: Bool = false, isFavorite: Bool = false) {
        self.id = UUID().uuidString
        self.title = title
        self.description = description
        self.isDone = isDone
        self.isFavorite = isFavorite
        self.createdOn = Date()
        self.updatedOn = Date()
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    func save() {
        let persistanceService = PersistanceService(fileName: "Todos.json")
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        do {
            guard let todosData = try persistanceService?.fetch() else { return }
            var todos = (try? decoder.decode([Todo].self, from: todosData)) ?? []
            
            todos.append(self)
            
            let encodedTodosData = try encoder.encode(todos)
            
            try persistanceService?.save(encodedTodosData)
        } catch {
            print("❌ Error in \(#function) ", error)
        }
    }
    
    func update(title: String? = nil, description: String? = nil, isDone: Bool? = nil, isFavorite: Bool? = nil) {
        let persistanceService = PersistanceService(fileName: "Todos.json")
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        do {
            guard let todosData = try persistanceService?.fetch() else { return }
            var todos = (try? decoder.decode([Todo].self, from: todosData)) ?? []
            
            guard let indexToUpdate = todos.firstIndex(where: { $0.id == id }) else {
                return
            }
            
            let updatedTodo = Todo(title: title ?? self.title,
                                   description: description ?? self.description,
                                   isDone: isDone ?? self.isDone,
                                   isFavorite: isFavorite ?? self.isFavorite)

            todos[indexToUpdate] = updatedTodo
            
            let encodedTodosData = try encoder.encode(todos)

            try persistanceService?.save(encodedTodosData)
        } catch {
            print("❌ Error in \(#function) ", error)
        }
    }
    
    func delete() {
        let persistanceService = PersistanceService(fileName: "Todos.json")
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        do {
            guard let todosData = try persistanceService?.fetch() else { return }
            var todos = (try? decoder.decode([Todo].self, from: todosData)) ?? []
            
            guard let indexToDelete = todos.firstIndex(where: { $0.id == id }) else {
                return
            }

            todos.remove(at: indexToDelete)
            
            let encodedTodosData = try encoder.encode(todos)

            try persistanceService?.save(encodedTodosData)
        } catch {
            print("❌ Error in \(#function) ", error)
        }
    }
    
    static func fetch() -> [Self] {
        do {
            let persistanceService = PersistanceService(fileName: "Todos.json")
            let decoder = JSONDecoder()
            
            guard let todosData = try persistanceService?.fetch() else { return [] }
            let todos = (try decoder.decode([Todo].self, from: todosData)) 
            
            return todos
        } catch {
            print("❌ Error in \(#function) ", error)
            return []
        }
    }
}


protocol Repository {
    static func fetch() -> [Self]
}


