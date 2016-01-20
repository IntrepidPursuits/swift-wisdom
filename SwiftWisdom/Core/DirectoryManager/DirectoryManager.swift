//
//  DirectoryManager.swift
//  bmap
//
//  Created by Logan Wright on 12/2/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

public final class DirectoryManager {
    
    enum Error : ErrorType {
        case UnableToCreatePath(url: NSURL)
    }
    
    private let directoryName: String
    private let fileManager: NSFileManager
    private let directoryUrl: NSURL
    
    // MARK: All Files
    
    public var allFilesInDirectory: [String] {
        guard let path = directoryUrl.path else { return [] }
        let all = try? fileManager.subpathsOfDirectoryAtPath(path)
        return all ?? []
    }
    
    // MARK: Initializer
    
    public init(directoryName: String, fileManager: NSFileManager = NSFileManager.defaultManager()) {
        self.directoryName = directoryName
        self.fileManager = fileManager
        // Should fail if not available
        self.directoryUrl = try! fileManager.directoryPathWithName(directoryName)
    }
    
    // MARK: Move
    
    public func moveFileIntoDirectory(originUrl originUrl: NSURL, targetName: String) throws {
        let filePath = directoryUrl.URLByAppendingPathComponent(targetName)
        guard let originPath = originUrl.path, targetPath = filePath.path else { return }
        if fileManager.fileExistsAtPath(targetPath) {
            try deleteImageWithFileName(targetName)
        }
        try fileManager.moveItemAtPath(originPath, toPath: targetPath)
    }
    
    // MARK: Write
    
    public func writeData(data: NSData, withName name: String = NSUUID().UUIDString) -> Bool {
        let filePath = directoryUrl.URLByAppendingPathComponent(name)
        guard let path = filePath.path else { return false }
        return data.writeToFile(path, atomically: true)
    }
    
    public func writeDataInBackground(data: NSData, withName name: String = NSUUID().UUIDString, completion: (fileName: String, success: Bool) -> Void = { _ in }) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            let success = self.writeData(data, withName: name)
            dispatch_async(dispatch_get_main_queue()) {
                completion(fileName: name, success: success)
            }
        })
    }
    
    // MARK: Delete
    
    public func deleteImageWithFileName(fileName: String) throws {
        let fileUrl = directoryUrl.URLByAppendingPathComponent(fileName)
        guard let path = fileUrl.path else {
            throw Error.UnableToCreatePath(url: fileUrl)
        }
        try fileManager.removeItemAtPath(path)
    }
    
    // MARK: Fetch
    
    public func fetchFileWithName(fileName: String) -> NSData? {
        let filePath = directoryUrl.URLByAppendingPathComponent(fileName)
        guard let path = filePath.path else { return nil }
        return NSData(contentsOfFile: path)
    }
}

extension NSFileManager {
    private func directoryPathWithName(directoryName: String) throws -> NSURL {
        let pathsArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        guard let pathString = pathsArray.first, let documentsDirectoryPath = NSURL(string: pathString) else { fatalError("Unable to create directory") }
        let directoryPath = documentsDirectoryPath.URLByAppendingPathComponent(directoryName)
        try createDirectoryIfNecessary(directoryPath)
        return directoryPath
    }
    
    private func createDirectoryIfNecessary(directoryPath: NSURL) throws {
        guard let path = directoryPath.path else { throw DirectoryManager.Error.UnableToCreatePath(url: directoryPath) }
        guard !fileExistsAtPath(path) else { return }
        try createDirectoryAtPath(path, withIntermediateDirectories: false, attributes: nil)
    }
}
