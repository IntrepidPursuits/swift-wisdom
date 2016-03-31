//
//  Result.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 11/13/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

public enum Result<T> {
    case Success(T)
    case Failure(ErrorType)
}

extension Result {
    public var isSuccess: Bool {
        guard case .Success(_) = self else { return false }
        return true
    }
    
    public var isFailure: Bool {
        guard case .Failure(_) = self else { return false }
        return true
    }
}

extension Result {
    public var value: T? {
        guard case let .Success(value) = self else { return nil }
        return value
    }
    
    public var error: ErrorType? {
        guard case let .Failure(error) = self else { return nil }
        return error
    }
}

extension Result {
    public func extract() throws -> T {
        switch self {
        case .Success(let val):
            return val
        case .Failure(let err):
            throw err
        }
    }
}
