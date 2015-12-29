//
//  After.swift
//
//  Created by Logan Wright on 10/24/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import Foundation

// MARK: Now

public func Main(function: Block) {
    dispatch_async(dispatch_get_main_queue(), function)
}

public func Background(function: Block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), function)
}

// MARK: Later

public func After(after: NSTimeInterval, on queue: dispatch_queue_t = dispatch_get_main_queue(), op: Block) {
    let seconds = Int64(after * Double(NSEC_PER_SEC))
    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, seconds)
    
    dispatch_after(dispatchTime, queue, op)
}

public func RepeatAtInterval(interval: NSTimeInterval, numberOfTimes: Int, op: () -> (), on queue: dispatch_queue_t = dispatch_get_main_queue(), completion: Void -> Void = {}) {
    let numberOfTimesLeft = numberOfTimes - 1
    
    let wrappedCompletion: Void -> Void
    if numberOfTimesLeft > 0 {
        wrappedCompletion = {
            RepeatAtInterval(interval, numberOfTimes: numberOfTimesLeft, op: op, completion: completion)
        }
    } else {
        wrappedCompletion = completion
    }
    
    let wrappedOperation: Void -> Void = {
        op()
        wrappedCompletion()
    }
    
    After(interval, on: queue, op: wrappedOperation)
}
