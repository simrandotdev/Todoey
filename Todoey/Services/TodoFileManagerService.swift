//
//  TodoService.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-12.
//

import Foundation

protocol TodoServicable {
    func fetch() throws -> [Todo]
    func save(todo: Todo) throws
    func update(todo oldTodo: Todo, with newTodo: Todo) throws
    func delete(_ todo: Todo) throws
}

class TodoFileManagerService: TodoServicable {
    
    private var persistanceService: PersistanceServicable? = FileManagerPersistanceService(fileName: "Todos.json")
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func fetch() throws -> [Todo] {
        guard let todosData = try persistanceService?.read() else { return [] }
        let todos = (try decoder.decode([Todo].self, from: todosData))

        return todos
    }
    
    func save(todo: Todo) throws {
        guard let todosData = try persistanceService?.read() else { return }
        var todos = (try? decoder.decode([Todo].self, from: todosData)) ?? []
        
        todos.append(todo)
        
        let encodedTodosData = try encoder.encode(todos)

        try persistanceService?.write(encodedTodosData)
    }
    
    func update(todo oldTodo: Todo, with newTodo: Todo) throws {

        guard let todosData = try persistanceService?.read() else { return }
        var todos = (try? decoder.decode([Todo].self, from: todosData)) ?? []
        
        guard let indexToUpdate = todos.firstIndex(where: { $0.id == oldTodo.id }) else {
            return
        }

        todos[indexToUpdate] = newTodo
        
        let encodedTodosData = try encoder.encode(todos)

        try persistanceService?.write(encodedTodosData)
        
    }
    
    func delete(_ todo: Todo) throws {
        guard let todosData = try persistanceService?.read() else { return }
        var todos = (try? decoder.decode([Todo].self, from: todosData)) ?? []
        
        guard let indexToDelete = todos.firstIndex(where: { $0.id == todo.id }) else {
            return
        }

        todos.remove(at: indexToDelete)
        
        let encodedTodosData = try encoder.encode(todos)

        try persistanceService?.write(encodedTodosData)
    }
}
