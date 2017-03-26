//
//  FileManager+Convenience.swift
//  PitchPerfect
//
//  Created by Shobhit Gupta on 24/03/17.
//  Copyright © 2017 Shobhit Gupta. All rights reserved.
//

import Foundation


public extension FileManager {
    
    public func uniqueFileName(withExtension fileExtension: String? = nil) -> String {
        var uniqueFileName = NSUUID().uuidString
        if let fileExtension = fileExtension {
            uniqueFileName.append(".\(fileExtension)")
        }
        return uniqueFileName
    }
    
    
    public func createPathForFile(_ name: String? = nil,
                                  withExtension fileExtension: String? = nil,
                                  relativeTo directory: SearchPathDirectory = ReusableConstants.FileManager.DafaultSearchPathDirectory,
                                  at subPath: String?,
                                  domainMask: SearchPathDomainMask = ReusableConstants.FileManager.DefaultSearchPathDomainMask) throws -> URL {
        
        // Get a path to folder that will contain the file
        let folderURL = try createPathForFolder(at: subPath, relativeTo: directory, domainMask: domainMask)
        
        // Create a folder at folder path
        try createDirectory(atPath: folderURL.path, withIntermediateDirectories: true, attributes: nil)
        
        // Create a file path for a file inside the above folder
        let fileURL: URL
        if let name = name {
            fileURL = folderURL.appendingPathComponent(name)
        } else {
            fileURL = folderURL.appendingPathComponent(uniqueFileName(withExtension: fileExtension))
        }
        
        return fileURL
        
    }
    
    
    public func createPathForFolder(at subPath: String?,
                                      relativeTo directory: SearchPathDirectory = ReusableConstants.FileManager.DafaultSearchPathDirectory,
                                      domainMask: SearchPathDomainMask = ReusableConstants.FileManager.DefaultSearchPathDomainMask) throws -> URL {
        
        guard let pathForDirectory = NSSearchPathForDirectoriesInDomains(directory, domainMask, true).first else {
            throw ReusableError.FileManager.pathNotFound(forDirectory: directory, inDomain: domainMask)
        }
        
        // Create folder path
        let folderURL: URL
        if let subPath = subPath {
            folderURL = URL(fileURLWithPath: pathForDirectory).appendingPathComponent(subPath, isDirectory: true)
        } else {
            folderURL = URL(fileURLWithPath: pathForDirectory)
        }
        
        return folderURL
        
    }
    
}


public extension ReusableConstants {
    
    enum FileManager {
        static let DafaultSearchPathDirectory: Foundation.FileManager.SearchPathDirectory = .documentDirectory
        static let DefaultSearchPathDomainMask: Foundation.FileManager.SearchPathDomainMask = .userDomainMask
    }
    
}



public extension ReusableError {
    
    enum FileManager: Error {
        case pathNotFound(forDirectory: Foundation.FileManager.SearchPathDirectory, inDomain: Foundation.FileManager.SearchPathDomainMask)
        
        var localizedDescription: String {
            var description = "FileManager Error: "
            switch self {
            case let .pathNotFound(directory, domain):
                description += "Path not found for \(directory) in \(domain)"
            }
            return description
        }
    }
    
}
