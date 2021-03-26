//
//  FileManager.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 24/07/2020.
//  Some of original code can be found here:
// https://www.iosapptemplates.com/blog/ios-development/data-persistence-ios-swift
//

import Foundation

class FilesManager {
    enum Error: Swift.Error {
        case fileAlreadyExists
        case invalidDirectory
        case writtingFailed
        case fileNotExists
        case readingFailed
    }
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let storageFileName: String = "Storage.txt"

    let fileManager: FileManager
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }

    func save(input: [Refuel]) throws {
        guard let url = makeURL(forFileNamed: storageFileName) else {
            throw Error.invalidDirectory
        }
        if fileManager.fileExists(atPath: url.absoluteString) {
            throw Error.fileAlreadyExists
        }
        do {
            let data = try encoder.encode(input)
            try data.write(to: url)
        } catch {
            debugPrint(error)
            throw Error.writtingFailed
        }
    }
    
    private func makeURL(forFileNamed fileName: String) -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }
    
    func getDecoded() throws -> [Refuel] {
        guard let url = makeURL(forFileNamed: storageFileName) else {
            throw Error.invalidDirectory
        }
        
        do {
            let data = try Data(contentsOf: url)
            if let decodedData = try? decoder.decode([Refuel].self, from: data) {
                return decodedData
            }
        } catch {
            debugPrint(error)
            throw Error.readingFailed
        }
        
        return [Refuel]()
    }
}
