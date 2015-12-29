//
//  Downloader.swift
//  bmap
//
//  Created by Logan Wright on 12/2/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import UIKit

public final class Downloader : NSObject, NSURLSessionDownloadDelegate {
    
    public enum State {
        case Began
        case InProgress(CGFloat)
        case Completed(Result<NSURL>)
    }
    
    public let url: NSURL
    public let id = NSUUID().UUIDString
    
    private var updater: (State -> Void)?
    
    private lazy var session: NSURLSession =
    NSURLSession(
        configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
        delegate: self,
        delegateQueue: NSOperationQueue.currentQueue()
    )
    
    public init(url: NSURL) {
        self.url = url
    }
    
    public func start(updater: State -> Void) {
        self.updater = updater
        self.updater?(.Began)
        downloadFileFromRemoteUrl(url)
    }
    
    private func downloadFileFromRemoteUrl(url: NSURL) {
        let task = session.downloadTaskWithURL(url)
        task.resume()
    }
    
    public func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        guard let error = error else { return }
        updater?(.Completed(.Failure(error)))
        updater = nil
    }
    
    // MARK: NSURLSessionDownloadDelegate
    
    public func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        updater?(.Completed(.Success(location)))
        updater = nil
    }
    
    public func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        updater?(.InProgress(downloadTask.percentageDownloaded))
    }
    
    public func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        updater?(.Began)
        updater?(.InProgress(downloadTask.percentageDownloaded))
    }
}

func ==(lhs: Downloader, rhs: Downloader) -> Bool {
    return lhs.id == rhs.id
}

func !=(lhs: Downloader, rhs: Downloader) -> Bool {
    return !(lhs == rhs)
}

extension NSURLSessionTask {
    var percentageDownloaded: CGFloat {
        let received = CGFloat(countOfBytesReceived)
        let expected = CGFloat(countOfBytesExpectedToReceive)
        let percentage = received / expected
        return min(percentage, 1)
    }
}
