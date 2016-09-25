//
//  After.swift
//
//  Created by Logan Wright on 10/24/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import Foundation

// MARK: Now

public func Main(_ function: @escaping Block) {
    DispatchQueue.main.async(execute: function)
}

public func Background(_ function: @escaping Block) {
    DispatchQueue.global(qos: .background).async(execute: function)
}

// MARK: Later

public func After(_ after: TimeInterval, on queue: DispatchQueue = DispatchQueue.main, op: @escaping Block) {
    let seconds = Int64(after * Double(NSEC_PER_SEC))
    let dispatchTime = DispatchTime.now() + Double(seconds) / Double(NSEC_PER_SEC)
    
    queue.asyncAfter(deadline: dispatchTime, execute: op)
}

public func RepeatAtInterval(_ interval: TimeInterval, numberOfTimes: Int, op: @escaping () -> (), on queue: DispatchQueue = DispatchQueue.main, completion: @escaping (Void) -> Void = {}) {
    let numberOfTimesLeft = numberOfTimes - 1
    
    let wrappedCompletion: (Void) -> Void
    if numberOfTimesLeft > 0 {
        wrappedCompletion = {
            RepeatAtInterval(interval, numberOfTimes: numberOfTimesLeft, op: op, completion: completion)
        }
    } else {
        wrappedCompletion = completion
    }
    
    let wrappedOperation: (Void) -> Void = {
        op()
        wrappedCompletion()
    }
    
    After(interval, on: queue, op: wrappedOperation)
}
