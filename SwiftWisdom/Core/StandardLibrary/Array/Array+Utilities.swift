public extension Array {
    public func ip_subArrayFromIndices(indices: [Int]) -> [Element] {
        var subArray: [Element] = []
        for (idx, element) in enumerate() {
            if indices.contains(idx) {
                subArray.append(element)
            }
        }
        return subArray
    }

    public func ip_passesTest(@noescape test: (element: Element) -> Bool) -> Bool {
        for ob in self {
            if test(element: ob) {
                return true
            }
        }
        return false
    }
}

public extension Array where Element: Equatable {
    public mutating func ip_remove(objectToRemove: Element) -> Bool {
        for (idx, objectToCompare) in enumerate() where objectToRemove == objectToCompare {
            removeAtIndex(idx)
            return true
        }
        return false
    }
}

public extension Array where Element: Hashable {
    public func ip_toSet() -> Set<Element> {
        return Set(self)
    }
}

extension ArraySlice {
    public func ip_toArray() -> Array<Element> {
        return Array(self)
    }
}

extension Array {
    public mutating func ip_removeFirst(@noescape matcher: Generator.Element -> Bool) {
        guard let idx = indexOf(matcher) else { return }
        removeAtIndex(idx)
    }
}

extension Array {
    public var ip_generator: AnyGenerator<Element> {
        var idx = 0
        let count = self.count
        return AnyGenerator {
            guard idx < count else { return nil }
            let this = idx
            idx += 1
            return self[this]
        }
    }
}

extension CollectionType {
    /// This grabs the element(s) in the middle of the array without doing any sorting.
    /// If there's an odd number the return array is just one element.
    /// If there are an even number it will return the two middle elements.
    public var ip_middleElements: [Generator.Element] {
        guard count > 0 else { return [] }
        let needsAverageOfTwo = count.toIntMax().ip_isEven
        let middle = startIndex.advancedBy(count / 2)
        if needsAverageOfTwo {
            let leftOfMiddle = startIndex.advancedBy((count / 2) - 1)
            return [self[middle], self[leftOfMiddle]]
        } else {
            return [self[middle]]
        }
    }
}

extension SequenceType where Generator.Element: Equatable {
    public func ip_mostCommonElements() -> [Generator.Element] {
        let sortedUniqueElements = self.ip_uniqueValues().sort {
                self.ip_countOf($0) > self.ip_countOf($1)
            }
        guard let first = sortedUniqueElements.first else { return [] }
        return sortedUniqueElements.lazy.filter {
            self.ip_countOf(first) == self.ip_countOf($0)
        }
    }
        
    public func ip_uniqueValues() -> [Generator.Element] {
        var buffer: [Generator.Element] = []
        forEach { element in
            if !buffer.contains(element) {
                buffer.append(element)
            }
        }
        return buffer
    }
    
    public func ip_countOf(element: Generator.Element) -> Int {
        return self.filter { $0 == element } .count
    }
}
