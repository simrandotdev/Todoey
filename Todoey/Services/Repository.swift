//
//  FileManagerServicableProtocol.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-13.
//

import Foundation

protocol Repository<T> {
    
    associatedtype T: Codable where T: Identifiable
    
    func fetch() throws -> [T]
    func save(item: T) throws
    func update(todo oldItem: T, with newItem: T) throws
    func delete(_ item: T) throws
}


extension Repository {
    
    private var persistanceService: PersistanceServicableProtocol?  { FileManagerPersistanceService(fileName: "\(self).json")}
    private var encoder: JSONEncoder { JSONEncoder() }
    private var decoder: JSONDecoder { JSONDecoder() }
    
    
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
