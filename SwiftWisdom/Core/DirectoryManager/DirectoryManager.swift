//
//  DirectoryManager.swift
//  bmap
//
//  Created by Logan Wright on 12/2/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

public final class DirectoryManager {

    enum DirectoryError: Error {
        case unableToCreatePath(url: NSURL)
        case unableToFindDirectory(name: String)
    }

    private let directoryName: String
    private let fileManager: FileManager
    private let directoryUrl: NSURL

    // MARK: All Files

    public var allFilesInDirectory: [String] {
        guard let path = directoryUrl.path else { return [] }
        let all = try? fileManager.subpathsOfDirectory(atPath: path)
        return all ?? []
    }

    // MARK: Initializer

    // swiftlint:disable force_try
    public init(directoryName: String, fileManager: FileManager = FileManager.default) {
        self.directoryName = directoryName
        self.fileManager = fileManager
        // Should fail if not available
        self.directoryUrl = try! fileManager.directoryPath(withName: directoryName)
    }
    // swiftlint:enable force_try

    // MARK: Move

    public func moveFileIntoDirectory(originUrl: NSURL, targetName: String) throws {
        let filePath = directoryUrl.appendingPathComponent(targetName)
        guard let originPath = originUrl.path, let targetPath = filePath?.path else { return }
        if fileManager.fileExists(atPath: targetPath) {
            try deleteFile(withName: targetName)
        }
        try fileManager.moveItem(atPath: originPath, toPath: targetPath)
    }

    // MARK: Write

    public func write(_ data: Data, withName name: String = UUID().uuidString) -> Bool {
        let filePath = directoryUrl.appendingPathComponent(name)
        guard let path = filePath?.path else { return false }
        return ((try? data.write(to: URL(fileURLWithPath: path), options: [.atomicWrite])) != nil)
    }

    public func writeInBackground(_ data: Data, withName name: String = UUID().uuidString, completion: @escaping (String, Bool) -> Void = { _ in }) {
        Background {
            let success = self.write(data, withName: name)
            Main {
                completion(name, success)
            }
        }
    }

    // MARK: Delete

    public func deleteFile(withName fileName: String) throws {
        let fileUrl = directoryUrl.appendingPathComponent(fileName)
        guard let path = fileUrl?.path else {
            throw DirectoryError.unableToFindDirectory(name: fileName)
        }
        try fileManager.removeItem(atPath: path)
    }

    // MARK: Fetch

    public func fetchFile(withName fileName: String) -> Data? {
        let filePath = directoryUrl.appendingPathComponent(fileName)
        guard let path = filePath?.path else { return nil }
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
}

extension FileManager {
    fileprivate func directoryPath(withName directoryName: String) throws -> NSURL {
        let pathsArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let pathString = pathsArray.first else { fatalError("Unable to create directory") }
        guard let documentsDirectoryPath = NSURL(string: pathString) else {
            throw DirectoryManager.DirectoryError.unableToFindDirectory(name: directoryName)
        }

        guard let directoryPath = documentsDirectoryPath.appendingPathComponent(directoryName) else {
            throw DirectoryManager.DirectoryError.unableToCreatePath(url: documentsDirectoryPath as NSURL)
        }
        try createDirectoryIfNecessary(directoryPath as NSURL)
        return directoryPath as NSURL
    }

    private func createDirectoryIfNecessary(_ directoryPath: NSURL) throws {
        guard let path = directoryPath.path else { return }
        guard !fileExists(atPath: path) else { return }
        try createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
    }
}
