//
//  Array+Utilities.swift
//  SwiftWisdom
//

import Foundation

extension Array {
    /// Creates an array containing the elements at the indices passed in. If an index is out of the array's bounds it will be ignored.
    ///
    /// - parameter indices: An array of integers representing the indices to grab
    ///
    /// - returns: An array of elements at the specified indices
    public func ip_subArray(fromIndices indices: [Int]) -> [Element] {
        var subArray: [Element] = []
        for (idx, element) in enumerated() {
            if indices.contains(idx) {
                subArray.append(element)
            }
        }
        return subArray
    }

    //TODO: Add documentation
    public func ip_passes(test: (Element) -> Bool) -> Bool {
        for ob in self {
            if test(ob) {
                return true
            }
        }
        return false
    }
}

extension Array {
    /// Separates this array's elements into chunks with a given length. Elements in these chunks and the chunks themselves
    /// are ordered the same way they are ordered in this array.
    ///
    /// If this array is empty, we always return an empty array.
    ///
    /// If `length` is not a positive number or if it's greater than or equal to this array's length, we return a new array
    /// with no chunks at all, plus the "remainder" which is this array itself iff `includeRemainder` is `true`.
    ///
    /// - parameter length: Number of elements in each chunk.
    /// - parameter includeRemainder: If set to `true`, include the remainder in returned array even if its length is less than
    ///   `length`. If set to `false`, discard the remainder. Defaults to `true`.
    ///
    /// - returns: New array of chunks of elements in this array.
    public func ip_chunks(of length: Int, includeRemainder: Bool = true) -> [[Element]] {
        guard !isEmpty else { return [] }
        guard length > 0 else { return includeRemainder ? [self] : [] }

        var chunks = [[Element]]()
        var nextChunkLeftIndex = 0
        let nextChunkRightIndex = { nextChunkLeftIndex + length - 1 }

        while nextChunkRightIndex() < count {
            let nextChunk = Array(self[nextChunkLeftIndex...nextChunkRightIndex()])
            chunks.append(nextChunk)
            nextChunkLeftIndex += length
        }

        if includeRemainder && nextChunkLeftIndex < count {
            let remainder = Array(self[nextChunkLeftIndex..<count])
            chunks.append(remainder)
        }

        return chunks
    }
}

extension Array where Element: Equatable {
    /// Removes a single element from the array.
    ///
    /// - parameter object: Element to remove
    ///
    /// - returns: Boolean value indicating the success/failure of removing the element.
    @discardableResult public mutating func ip_remove(object: Element) -> Bool {
        for (idx, objectToCompare) in enumerated() where object == objectToCompare {
            remove(at: idx)
            return true
        }
        return false
    }

    /// Removes multiple elements from an array.
    ///
    /// - parameter elements: Array of elements to remove
    public mutating func ip_remove(elements: [Element]) {
        self = self.filter { element in
            return !elements.contains(element)
        }
    }

    /// Returns NSNotFound for any element in elements that does not exist.
    ///
    /// - parameter elements: Array of Equatable elements
    ///
    /// - returns: Array of indexes or NSNotFound if element does not exist in self; count is equal to the count of `elements`
    public func ip_indices(ofElements elements: [Element]) -> [Int] {
        return elements.map { element in
            return index(of: element) ?? NSNotFound
        }
    }
}

extension Array where Element: Hashable {
    /// Converts an Array into a Set of the same type.
    ///
    /// - returns: Set of the array's elements
    public func ip_toSet() -> Set<Element> {
        return Set(self)
    }
}

extension Array {
    /// DEPRECATED: Use `ip_safely` instead.
    ///
    /// Provides a way to safely index into an array. If the index is beyond the array's 
    /// final element this method will return `nil`.
    ///
    /// - parameter safe: Index of the element to return
    ///
    /// - returns: An `Element` if the index was correct, or `nil` if it goes beyond the array
    @available(*, deprecated: 0.7.11, message: "Use `ip_safely` instead.")
    public subscript(ip_safe safe: Int) -> Element? {
        guard 0 <= safe && safe < count else { return nil }
        return self[safe]
    }

    /// Provides a way to safely index into an array. If the index is beyond the array's 
    /// bounds this method will return `nil`.
    ///
    /// - parameter index: Index of the element to return
    ///
    /// - returns: An `Element` if the index is valid, or `nil` if the index is outside the bounds of the array.
    public subscript(ip_safely index: Int) -> Element? {
        guard 0 <= index && index < count else { return nil }
        return self[index]
    }
}

extension Array {
    /// Removes the first instance of an element within an array.
    ///
    /// - parameter matcher: The element that should be removed
    public mutating func ip_removeFirst(matcher: (Iterator.Element) -> Bool) {
        guard let idx = index(where: matcher) else { return }
        remove(at: idx)
    }
}

extension Array {
    //TODO: Add documentation
    public var ip_generator: AnyIterator<Element> {
        var idx = 0
        let count = self.count
        return AnyIterator {
            guard idx < count else { return nil }
            let this = idx
            idx += 1
            return self[this]
        }
    }
}

extension Collection {
    /// This grabs the element(s) in the middle of the array without doing any sorting.
    /// If there's an odd number the return array is just one element.
    /// If there are an even number it will return the two middle elements.
    /// The two middle elements will be flipped if the array has an even number.
    public var ip_middleElements: [Iterator.Element] {
        guard count > 0 else { return [] }
        let needsAverageOfTwo = count.toIntMax().ip_isEven

        let middle = index(startIndex, offsetBy: count / 2)
        if needsAverageOfTwo {
            let leftOfMiddle = index(middle, offsetBy: -1)
            return [self[middle], self[leftOfMiddle]]
        } else {
            return [self[middle]]
        }
    }
}
