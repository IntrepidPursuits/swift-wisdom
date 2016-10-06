//
//  Sequence+Utilities.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 3/31/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

extension Sequence {
    /// Converts a `Sequence` into an `Array`.
    ///
    /// - returns: An array with the same elements as the sequence
    public func ip_toArray() -> Array<Iterator.Element> {
        return Array(self)
    }
}

extension Sequence {
    /// Takes a sequence of elements and splits it in two based on a filter.
    ///
    /// - parameter filter: The element to filter the sequences
    ///
    /// - throws: If the `forEach` loop fails
    ///
    /// - returns: A tuple of element sequences
    public func ip_split(withFilter filter: (Iterator.Element) throws -> Bool) rethrows -> (passed: [Iterator.Element], failed: [Iterator.Element]) {
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

extension Sequence where Iterator.Element: Equatable {
    /// Provides the most common element(s) of a sequence.
    ///
    /// - returns: The most common element(s)
    public func ip_mostCommonElements() -> [Iterator.Element] {
        let sortedUniqueElements = self.ip_uniqueValues().sorted {
            self.ip_count(ofElement: $0) > self.ip_count(ofElement: $1)
        }
        guard let first = sortedUniqueElements.first else { return [] }
        return sortedUniqueElements.lazy.filter {
            self.ip_count(ofElement: first) == self.ip_count(ofElement: $0)
        }
    }

    /// Provides only the unique values within a `Sequence`. ie: "1, 2, 2, 3" will return "1, 2, 3".
    ///
    /// - returns: Returns a sequence of the unique values
    public func ip_uniqueValues() -> [Iterator.Element] {
        var buffer: [Iterator.Element] = []
        forEach { element in
            if !buffer.contains(element) {
                buffer.append(element)
            }
        }
        return buffer
    }

    /// Finds the count of a certain element.
    ///
    /// - parameter element: The element to be counted
    ///
    /// - returns: Number of instances of the element within the set
    public func ip_count(ofElement element: Iterator.Element) -> Int {
        return self.filter { $0 == element } .count
    }

    /// Checks to see if all of the passed in elements are within the `Sequence`.
    ///
    /// - parameter all: A collection of elements
    ///
    /// - returns: `true` if the sequence contains `all`
    public func ip_contains<T: Sequence>(all: T) -> Bool where T.Iterator.Element == Iterator.Element {
        for e in all where !contains(e) {
            return false
        }
        return true
    }
}
