//
//  Sequence+Utilities.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 3/31/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

extension Sequence {
    public func ip_toArray() -> Array<Iterator.Element> {
        return Array(self)
    }
}

extension Sequence {
    public func ip_splitFilter(filter: @noescape (Iterator.Element) throws -> Bool) rethrows -> (passed: [Iterator.Element], failed: [Iterator.Element]) {
        var passed: [Iterator.Element] = []
        var failed: [Iterator.Element] = []
        try forEach {
            if try filter($0) {
                passed.append($0)
            } else {
                failed.append($0)
            }
        }
        return (passed, failed)
    }
}
