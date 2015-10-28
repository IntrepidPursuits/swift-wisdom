//
//  After.swift
//
//  Created by Logan Wright on 10/24/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

public func After(after: NSTimeInterval, op: () -> ()) {
    After(after, op: op, completion: nil)
}

public func After(after: NSTimeInterval, numberOfTimes: Int, op: () -> (), completion: Void -> Void = {}) {
    let numberOfTimesLeft = numberOfTimes - 1
    let wrappedCompletion: Void -> Void
    if numberOfTimesLeft > 0 {
        wrappedCompletion = {
            After(after, numberOfTimes: numberOfTimesLeft, op: op, completion: completion)
        }
    } else {
        wrappedCompletion = completion
    }
    
    After(after, op: op, completion: wrappedCompletion)
}

public func After(after: NSTimeInterval, op: () -> (), completion: (() -> Void)?) {
    let seconds = Int64(after * Double(NSEC_PER_SEC))
    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, seconds)
    dispatch_after(dispatchTime, dispatch_get_main_queue()) {
        let blockOp = NSBlockOperation(block: op)
        blockOp.completionBlock = completion
        NSOperationQueue.mainQueue().addOperation(blockOp)
    }
}