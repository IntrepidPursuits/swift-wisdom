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
public class TimeoutOperation : Foundation.Operation {
    
    private(set) var block: Block?
    
    private let duration: TimeInterval
    private let queue: DispatchQueue

    public init(duration: TimeInterval = 30,
                runQueue: DispatchQueue = DispatchQueue.main,
                timeoutQueue: OperationQueue = OperationQueue(),
                block: @escaping Block) {
        
        self.duration = duration
        self.block = block
        self.queue = runQueue
        super.init()
        
        timeoutQueue.addOperation(self)
    }
    
    override public func main() {
        After(duration, on: queue) { [weak self] in
            if let cancelled = self?.isCancelled, let block = self?.block, !cancelled {
                block()
            }
        }
    }
    
    override public func cancel() {
        super.cancel()
        block = nil
    }
}
