//
//  FileManager.swift
//  Mileage Tracker
//
//  Created by Alex Luna on 24/07/2020.
//  Some of original code can be found here: https://www.iosapptemplates.com/blog/ios-development/data-persistence-ios-swift
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

    let fileManager: FileManager
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }

    func save(fileNamed: String, data: Data) throws {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        if fileManager.fileExists(atPath: url.absoluteString) {
            throw Error.fileAlreadyExists
        }
        do {
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
    
    func read(fileNamed: String) throws -> Data {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        print(url)
        guard fileManager.fileExists(atPath: url.absoluteString) else {
            throw Error.fileNotExists
        }
        // TO DO: this shit is really storing data, but it's not reading nor throwing errors
        do {
            print(url)
            let string = try String(contentsOf: url)
            print(string)
            let data = try Data(contentsOf: url)
            print(data)
            return data
        } catch {
            debugPrint(error)
            throw Error.readingFailed
        }
    }
}
