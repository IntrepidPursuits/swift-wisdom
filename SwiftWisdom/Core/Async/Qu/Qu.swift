//
//  Qu.swift
//
//  Created by Logan Wright on 10/24/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

// swiftlint:disable identifier_name

import Foundation

/// Simple closure alias. Ensure that a `weak` reference is used if referencing anything that could create a retain cycle.
public typealias Block = () -> ()
/// Same style of closure alias to `Block`, but this one accepts a completion block to be executed afterwards.
public typealias CompletableBlock = (@escaping Block) -> ()

// MARK: Qu

public class Qu {

    // MARK: Priority Enumeration

    public enum Priority {
        case background
        case main
        case custom(OperationQueue)

        var queue: OperationQueue {
            switch self {
            case .background:
                return OperationQueue()
            case .main:
                return OperationQueue.main
            case .custom(let customQueue):
                return customQueue
            }
        }
    }

    public enum Dependency {
        case last
        case all
        case previous(Int)
    }

    // MARK: Properties

    private(set) var priority: Priority
    private(set) var operationQueue: OperationQueue

    /// Completion operation that will attempt to wait for other operations to finish and then execute.  If all operations have already executed before this operation is added, it will run immediately.  Even if you add operations afterwards.
    private(set) var completion: Operation? {
        willSet {
            if completion != nil && newValue != nil {
                print("*** Warning *** Setting multiple completion blocks will result in unpredictable behavior!")
            }
        }
    }

    // MARK: Initialization

    public required init(priority: Priority) {
        self.priority = priority
        self.operationQueue = priority.queue
    }

    // MARK: Class Functions

    public class func Background(_ block: @escaping Block) -> Self {
        let q = self.init(priority: .background)
        return q.Run(block)
    }

    public class func Main(_ block: @escaping Block) -> Self {
        let q = self.init(priority: .main)
        return q.Run(block)
    }

    public class func Custom(_ queue: OperationQueue, block: @escaping Block) -> Self {
        let q = self.init(priority: .custom(queue))
        return q.Run(block)
    }

    // MARK: Dispatching Functions

    public func Run(_ block: @escaping Block) -> Self {
        return queue(block)
    }

    public func Also(_ block: @escaping Block) -> Self {
        return queue(block)
    }

    public func Then(_ block: @escaping Block) -> Self {
        return ThenAfter(.last, block: block)
    }

    public func ThenAfter(_ dependency: Dependency, block: @escaping Block) -> Self {
        let blockOp = Operation(block: block)
        switch dependency {
        case .last:
            if let last = operationQueue.lastOperation {
                blockOp.addDependency(last)
            }
        case .previous(let previousOperationCount):
            let ops = operationQueue.ops
            let count = ops.count
            let start = count - previousOperationCount
            let dependentOperations = ops[start..<count]
            for op in dependentOperations {
                blockOp.addDependency(op)
            }
        case .all:
            for op in operationQueue.ops {
                blockOp.addDependency(op)
            }
        }
        return queue(blockOp)
    }

    // MARK: Completion

    @discardableResult public func Finally(_ block: @escaping Block) -> Self {
        let op = Operation(block: block)
        completion = op
        operationQueue.setCompletion(op)
        return self
    }

    @discardableResult public func FinallyOn(_ priority: Priority, block: @escaping Block) -> Self {
        let wrapped: Block = {
            if let queue = priority.queue.underlyingQueue {
                queue.async(execute: block)
            }
        }
        return Finally(wrapped)
    }

    // MARK: Queueing

    private func queue(_ block: @escaping Block) -> Self {
        return queue(Operation(block: block))
    }

    private func queue(_ op: Operation) -> Self {
        if let completion = completion {
            completion.addDependency(op)
        }
        operationQueue += op
        return self
    }

    /**
     Accepts a series of blocks and executes them sequentially.

     - Parameter blocks: An array of block functions conforming to the `CompletableBlock` style.
     */
    class func executeMultiple(blocks: [CompletableBlock]) {
        guard let block = blocks.first else { return }
        block {
            self.executeMultiple(blocks: Array(blocks.dropFirst()))
        }
    }
}

// MARK: Operation

class Operation: BlockOperation {

    private(set) var block: Block!

    init(block: @escaping Block) {
        super.init()
        self.block = block
        addExecutionBlock(self.block)
    }
}

extension Operation {
    override var description: String {
        return name ?? "[unnamed]"
    }
}

// MARK: NSOperationQueue+Operations

private extension OperationQueue {

    /// This is the most recently added operation.  According to the docs, `operations` are returned in the order they were added to the queue, NOT the order in which they are executed.
    var lastOperation: Operation? {
        return ops.last
    }

    /// May contain operations that are currently executing or waiting to execute. These may also include opeations that were executing when the array was accessed but have subsequently finished.
    var ops: [Operation] {
        return operations as? [Operation] ?? []
    }

    func setCompletion(_ block: @escaping Block) -> Operation {
        let blockOp = Operation(block: block)
        return setCompletion(blockOp)
    }

    @discardableResult func setCompletion(_ blockOp: Operation) -> Operation {
        for op in ops {
            blockOp.addDependency(op)
        }
        addOperation(blockOp)
        return blockOp
    }

    // MARK: Operators

    static func += (operationQueue: OperationQueue, block: @escaping Block) {
        operationQueue.addOperation(block)
    }
    static func += (operationQueue: OperationQueue, operation: Foundation.Operation) {
        operationQueue.addOperation(operation)
    }
}
