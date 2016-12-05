//
//  Downloader.swift
//  bmap
//
//  Created by Logan Wright on 12/2/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import UIKit

public final class Downloader : NSObject, URLSessionDownloadDelegate {
    
    public enum State {
        case began
        case inProgress(CGFloat)
        case completed(Result<URL>)
    }

    public enum DownloaderError : Error {
        case httpRequestFailed
    }
    
    public let url: URL
    public let id = UUID().uuidString
    
    private var updater: ((State) -> Void)?
    
    private lazy var session: Foundation.URLSession =
    Foundation.URLSession(
        configuration: URLSessionConfiguration.default,
        delegate: self,
        delegateQueue: OperationQueue.current
    )
    
    public init(url: URL) {
        self.url = url
    }
    
    public func start(_ updater: @escaping (State) -> Void) {
        self.updater = updater
        self.updater?(.began)
        downloadFileFromRemoteUrl(url)
    }
    
    private func downloadFileFromRemoteUrl(_ url: URL) {
        let task = session.downloadTask(with: url)
        task.resume()
    }

    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let error = error else { return }
        updater?(.completed(.failure(error)))
        updater = nil
    }
    
    // MARK: NSURLSessionDownloadDelegate
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let httpResponse = downloadTask.response as? HTTPURLResponse, !httpResponse.isSuccess {
            updater?(.completed(.failure(DownloaderError.httpRequestFailed)))
        } else {
            updater?(.completed(.success(location)))
        }
        updater = nil
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        updater?(.inProgress(downloadTask.ip_percentageDownloaded))
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        updater?(.began)
        updater?(.inProgress(downloadTask.ip_percentageDownloaded))
    }
}

extension URLSessionTask {
    public var ip_percentageDownloaded: CGFloat {
        let received = CGFloat(countOfBytesReceived)
        let expected = CGFloat(countOfBytesExpectedToReceive)
        let percentage = received / expected
        return min(percentage, 1)
    }
}

// MARK: Operator Overloads

extension Downloader {
    @nonobjc public static func == (lhs: Downloader, rhs: Downloader) -> Bool {
        return lhs.id == rhs.id
    }

    @nonobjc public static func != (lhs: Downloader, rhs: Downloader) -> Bool {
        return !(lhs == rhs)
    }
}

extension HTTPURLResponse {
    public var isSuccess: Bool {
        return 200...299 ~= statusCode
    }
}
