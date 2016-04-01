//
//  Sequence+Utilities.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 3/31/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

extension SequenceType {
    public func ip_toArray() -> Array<Generator.Element> {
        return Array(self)
    }
}

extension SequenceType {
    public func ip_splitFilter(@noescape filter: (Generator.Element) throws -> Bool) rethrows -> (passed: [Generator.Element], failed: [Generator.Element]) {
        var passed: [Generator.Element] = []
        var failed: [Generator.Element] = []
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
