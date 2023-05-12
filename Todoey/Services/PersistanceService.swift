//
//  PersistanceService.swift
//  Todoey
//
//  Created by Simran Preet Narang on 2023-05-11.
//

import Foundation

class PersistanceService {
    
    private var fileManager: FileManager
    private var filePath: URL
    
    init?(fileManager: FileManager = FileManager.default, fileName: String) {
        self.fileManager = fileManager
        
        guard let firstPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        self.filePath = firstPath.appendingPathComponent(fileName)
    }
    
    
    func fetch() throws -> Data {
        
        if !fileManager.fileExists(atPath: filePath.relativePath) {
            fileManager.createFile(atPath: filePath.relativePath, contents: nil)
        }
        
        return try Data(contentsOf: filePath)
    }
    
    func save(_ data: Data) throws{
        
        if !fileManager.fileExists(atPath: filePath.absoluteString) {
            fileManager.createFile(atPath: filePath.absoluteString, contents: nil)
        }
        
        try data.write(to: filePath)
    }
}
