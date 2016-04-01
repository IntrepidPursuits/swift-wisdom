//
//  Timeout.swift
//  bmap
//
//  Created by Logan Wright on 11/25/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

/**
 This classed is used to create a timeout operation that fires 
 after a given amount of time
 
 Setting to `nil` or calling `cancel()` will abort the timeout.
 */
public class TimeoutOperation : NSOperation {
    
    private(set) var block: Block?
    
    private let duration: NSTimeInterval
    private let queue: dispatch_queue_t

    public init(duration: NSTimeInterval = 30,
                runQueue: dispatch_queue_t = dispatch_get_main_queue(),
                timeoutQueue: NSOperationQueue = NSOperationQueue(),
                block: Block) {
        
        self.duration = duration
        self.block = block
        self.queue = runQueue
        super.init()
        
        timeoutQueue.addOperation(self)
    }
    
    override public func main() {
        After(duration, on: queue) { [weak self] in
            if let cancelled = self?.cancelled, let block = self?.block where !cancelled {
                block()
            }
        }
    }
    
    override public func cancel() {
        super.cancel()
        block = nil
    }
}
