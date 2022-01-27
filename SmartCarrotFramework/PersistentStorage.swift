//
//  PersistentStorage.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal enum PersistanceType {
    case ephemeral
    case persistent
}

/// Singlton class for persistent storage. To be used to save all the learnings
/// PersistanceType should be set to .ephemeral for unit tests
internal class PersistentStorage {
    private let URL_CARROT_FRAMEWORK_STORAGE = "v1-data-ios.cldat"
    
    private static let _sharedPersistentStorage = PersistentStorage()
    
    /// The words dictionary, it is connected to the weightsMatrix
    internal var _wordsDictionary:[String] = [String]()
    
    /// Weights Matrix, synced with the words dictionary (the same number of rows = words)
    internal var _weightsMatrix:[[Float32]] = [[Float32]]()
    
    internal var _densityMatrix:[[Float32]] = [[Float32]]()
    
    internal var _dictionary:[[Float32]] = [[Float32]]()
    
    internal class func shared() -> PersistentStorage {
        return self._sharedPersistentStorage
    }
    
    internal func reset() {
        _wordsDictionary = [String]()
        _weightsMatrix = [[Float32]]()
        _densityMatrix = [[Float32]]()
        _dictionary = [[Float32]]()
    }
    
    internal func save(persistance: PersistanceType) throws {
        if persistance == .persistent {
            let allTogether: [Any] = [_weightsMatrix, _densityMatrix, _dictionary, _wordsDictionary]
            
            do {
                let archivedData = try NSKeyedArchiver.archivedData(withRootObject: allTogether, requiringSecureCoding: false)
                try archivedData.write(to: getUrl(forFileNamed: URL_CARROT_FRAMEWORK_STORAGE)!, options: .atomic)
            } catch {
                print(error)
                throw CarrotContextError.saveError
            }
        }
    }
    
    internal func load(persistance: PersistanceType) -> (wordDictionary:[String], weightsMatix:[[Float32]], densityMatrix: [[Float32]], dictionary:[[Float32]]) {
        if persistance == .persistent {
            do {
                if fileExists(fileName: URL_CARROT_FRAMEWORK_STORAGE) {
                    let readData = try Data.init(contentsOf: getUrl(forFileNamed: URL_CARROT_FRAMEWORK_STORAGE)!)
                    let readArray = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(readData) as! [Any]
                    
                    self._weightsMatrix = readArray[0] as! [[Float32]]
                    self._densityMatrix = readArray[1] as! [[Float32]]
                    self._dictionary = readArray[2] as! [[Float32]]
                    self._wordsDictionary = readArray[3] as! [String]
                } 
            } catch {
                print(error)
                reset()
            }
        }
        
        return (self._wordsDictionary, self._weightsMatrix, self._densityMatrix, self._dictionary)
    }
    
    /// Checks if a file with a given name exists
    private func fileExists(fileName: String) -> Bool {
        guard let url = getUrl(forFileNamed: fileName) else {
            return false
        }
        
        return FileManager.default.fileExists(atPath: url.path)
    }

    // returns a url to the file
    private func getUrl(forFileNamed fileName: String) -> URL? {
        var url:URL?
        
        do {
            url = try FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        } catch {
            print(error)
            return nil
        }
        
        return url!.appendingPathComponent(fileName)
    }
}
