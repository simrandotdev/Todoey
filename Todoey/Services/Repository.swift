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
