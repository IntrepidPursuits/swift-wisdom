//
//  Result.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 11/13/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

@available(swift, deprecated: 5.0, message: "use Swift.Result instead", renamed: "Result")
public enum IPResult<T> {
    case success(T)
    case failure(Error)

    public var isSuccess: Bool {
        guard case .success(_) = self else { return false }
        return true
    }

    public var isFailure: Bool {
        guard case .failure(_) = self else { return false }
        return true
    }

    public var value: T? {
        guard case let .success(value) = self else { return nil }
        return value
    }

    public var error: Error? {
        guard case let .failure(error) = self else { return nil }
        return error
    }

    public func extract() throws -> T {
        switch self {
        case .success(let val):
            return val
        case .failure(let err):
            throw err
        }
    }
}
