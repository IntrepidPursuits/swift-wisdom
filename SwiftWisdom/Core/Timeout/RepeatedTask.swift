//
//  RepeatedTask.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 5/12/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import Foundation

public class RepeatedTask {
    let operation: Block
    let timeBetweenOps: TimeInterval

    /// nil repeatCount means infinite
    let repeatCount: Int?
    let queue: DispatchQueue

    private var currentCount = 0
    public private(set) var isComplete = false
    public private(set) var isActive = false

    public init(repeatCount: Int? = nil, timeBetweenOps: TimeInterval = 0, on queue: DispatchQueue = DispatchQueue.main, operation: @escaping Block) {
        self.operation = operation
        self.timeBetweenOps = timeBetweenOps
        self.repeatCount = repeatCount
        self.queue = queue
        start()
    }

    public func start() {
        guard !isActive else { return }
        isActive = true
        queue.async { [weak self] in
            self?.executeOp()
        }
    }

    /// Pauses the task, maintaining the repeat count and same closure.
    public func stop() {
        guard isActive else { return }
        isActive = false
    }

    private func executeOp() {
        if let count = repeatCount, currentCount >= count {
            isComplete = true
            isActive = false
            return
        }
        guard isActive else { return }

        operation()
        currentCount += 1
        After(timeBetweenOps, on: queue) { [weak self] in
            self?.executeOp()
        }
    }
}
