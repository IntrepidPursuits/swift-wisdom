//
//  After.swift
//
//  Created by Logan Wright on 10/24/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import Foundation

public func After(after: NSTimeInterval, op: () -> ()) {
    After(after, op: op, completion: nil)
}

public func After(after: NSTimeInterval, op: () -> (), dispatchQueue: dispatch_queue_t = dispatch_get_main_queue(), completion: (() -> Void)?) {
    let seconds = Int64(after * Double(NSEC_PER_SEC))
    let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, seconds)
    dispatch_after(dispatchTime, dispatchQueue) {
        op()
        completion?()
    }
}

public func RepeatAtInterval(interval: NSTimeInterval, numberOfTimes: Int, op: () -> (), completion: Void -> Void = {}) {
    let numberOfTimesLeft = numberOfTimes - 1
    let wrappedCompletion: Void -> Void
    if numberOfTimesLeft > 0 {
        wrappedCompletion = {
            RepeatAtInterval(interval, numberOfTimes: numberOfTimesLeft, op: op, completion: completion)
        }
    } else {
        wrappedCompletion = completion
    }
    
    After(interval, op: op, completion: wrappedCompletion)
}
