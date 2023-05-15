//
//  TodoService.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-12.
//

import Foundation

class TodoRepository: Repository {
    
    typealias T = Todo
    
    private var persistanceService: FileManagerServiceProtocol?
    private var encoder: JSONEncoder
    private var decoder: JSONDecoder
    
    init(persistanceService: FileManagerServiceProtocol? = FileManagerService(fileName: "todos.json"),
         encoder: JSONEncoder = JSONEncoder(),
         decoder: JSONDecoder = JSONDecoder()) {
        self.persistanceService = persistanceService
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func fetch() throws -> [T] {

        guard let itemsData = try persistanceService?.read() else { return [] }
        let items = (try decoder.decode([T].self, from: itemsData))

        return items
    }

    func save(item: T) throws {
        
        guard let itemData = try persistanceService?.read() else { return }
        var items = (try? decoder.decode([T].self, from: itemData)) ?? []

        items.append(item)

        let encodedItemsData = try encoder.encode(items)

        try persistanceService?.write(encodedItemsData)
    }

    func update(todo oldItem: T, with newItem: T) throws {
        
        guard let itemsData = try persistanceService?.read() else { return }
        var items = (try? decoder.decode([T].self, from: itemsData)) ?? []

        guard let indexToUpdate = items.firstIndex(where: { $0.id == oldItem.id }) else {
            return
        }

        items[indexToUpdate] = newItem

        let encodedItemsData = try encoder.encode(items)

        try persistanceService?.write(encodedItemsData)
    }

    func delete(_ item: T) throws {
        
        guard let itemsData = try persistanceService?.read() else { return }
        var items = (try? decoder.decode([T].self, from: itemsData)) ?? []

        guard let indexToDelete = items.firstIndex(where: { $0.id == item.id }) else {
            return
        }

        items.remove(at: indexToDelete)

        let encodedItemsData = try encoder.encode(items)

        try persistanceService?.write(encodedItemsData)
    }
}
