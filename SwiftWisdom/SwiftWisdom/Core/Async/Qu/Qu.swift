//
//  Qu.swift
//
//  Created by Logan Wright on 10/24/15.
//  Copyright © 2015 lowriDevs. All rights reserved.
//

import Foundation

public typealias Block = () -> ()

// MARK: Qu

public class Qu {
    
    // MARK: Priority Enumeration
    
    public enum Priority {
        case Background
        case Main
        case Custom(NSOperationQueue)
        
        var queue: NSOperationQueue {
            switch self {
            case .Background:
                return NSOperationQueue()
            case .Main:
                return NSOperationQueue.mainQueue()
            case .Custom(let customQueue):
                return customQueue
            }
        }
    }
    
    public enum Dependency {
        case Last
        case All
        case Previous(Int)
    }
    
    // MARK: Properties
    
    private(set) var priority: Priority
    private(set) var operationQueue: NSOperationQueue
    
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
    
    public class func Background(block: Block) -> Self {
        let q = self.init(priority: .Background)
        return q.Run(block)
    }
    
    public class func Main(block: Block) -> Self {
        let q = self.init(priority: .Main)
        return q.Run(block)
    }
    
    public class func Custom(queue: NSOperationQueue, block: Block) -> Self {
        let q = self.init(priority: .Custom(queue))
        return q.Run(block)
    }
    
    // MARK: Dispatching Functions
    
    public func Run(block: Block) -> Self {
        return queue(block)
    }
    
    public func Also(block: Block) -> Self {
        return queue(block)
    }
    
    public func Then(block: Block) -> Self {
        return ThenAfter(.Last, block: block)
    }
    
    public func ThenAfter(dependency: Dependency, block: Block) -> Self {
        let blockOp = Operation(block: block)
        switch dependency {
        case .Last:
            if let last = operationQueue.lastOperation {
                blockOp.addDependency(last)
            }
        case .Previous(let previousOperationCount):
            let ops = operationQueue.ops
            let count = ops.count
            let start = count - previousOperationCount
            let dependentOperations = ops[start..<count]
            for op in dependentOperations {
                blockOp.addDependency(op)
            }
        case .All:
            for op in operationQueue.ops {
                blockOp.addDependency(op)
            }
        }
        return queue(blockOp)
    }
    
    // MARK: Completion
    
    public func Finally(block: Block) -> Self {
        let op = Operation(block: block)
        completion = op
        operationQueue.setCompletion(op)
        return self
    }
    
    public func FinallyOn(priority: Priority, block: Block) -> Self {
        let wrapped: Block = {
            if let queue = priority.queue.underlyingQueue {
                dispatch_async(queue, block)
            }
        }
        return Finally(wrapped)
    }
    
    // MARK: Queueing
    
    private func queue(block: Block) -> Self {
        return queue(Operation(block: block))
    }
    
    private func queue(op: Operation) -> Self {
        if let completion = completion {
            completion.addDependency(op)
        }
        operationQueue += op
        return self
    }
}

// MARK: Operation

class Operation : NSBlockOperation {
    
    private(set) var block: Block!
    
    init(block: Block) {
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

// MARK: Operators

func +=(operationQueue: NSOperationQueue, block: Block) {
    operationQueue.addOperationWithBlock(block)
}
func +=(operationQueue: NSOperationQueue, operation: NSOperation) {
    operationQueue.addOperation(operation)
}

// MARK: NSOperationQueue+Operations

private extension NSOperationQueue {
    
    /// This is the most recently added operation.  According to the docs, `operations` are returned in the order they were added to the queue, NOT the order in which they are executed.
    var lastOperation: Operation? {
        return ops.last
    }
    
    var ops: [Operation] {
        return operations as? [Operation] ?? []
    }
    
    func setCompletion(block: Block) -> Operation {
        let blockOp = Operation(block: block)
        return setCompletion(blockOp)
    }
    
    func setCompletion(blockOp: Operation) -> Operation {
        for op in ops {
            blockOp.addDependency(op)
        }
        addOperation(blockOp)
        return blockOp
    }
}