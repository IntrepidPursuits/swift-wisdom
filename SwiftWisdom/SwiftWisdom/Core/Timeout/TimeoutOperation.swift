//
//  Timeout.swift
//  bmap
//
//  Created by Logan Wright on 11/25/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

public class TimeoutOperation : NSOperation {
    private(set) var block: Block?
    let duration: NSTimeInterval
    let queue: dispatch_queue_t
    public init(duration: NSTimeInterval = 30, runQueue: dispatch_queue_t = dispatch_get_main_queue(), block: Block) {
        self.duration = duration
        self.block = block
        self.queue = runQueue
        super.init()
        
        NSOperationQueue().addOperation(self)
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
