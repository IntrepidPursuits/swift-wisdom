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
        for (idx, objectToCompare) in enumerate() {
            if objectToRemove == objectToCompare {
                removeAtIndex(idx)
                return true
            }
        }
        return false
    }
}

public extension Array where Element: Hashable {
    public func ip_toSet() -> Set<Element> {
        return Set(self)
    }
}

extension Array {
    mutating func ip_removeFirst(@noescape matcher: Generator.Element -> Bool) {
        guard let idx = indexOf(matcher) else { return }
        removeAtIndex(idx)
    }
}
