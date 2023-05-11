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
}


protocol Repository {
    static func fetch() -> [Self]
}


