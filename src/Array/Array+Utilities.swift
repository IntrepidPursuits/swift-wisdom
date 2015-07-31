public extension Array {
    func ip_subArrayFromIndices(indices: [Int]) -> [Element] {
        var subArray: [Element] = []
        for (idx, element) in enumerate() {
            if indices.contains(idx) {
                subArray.append(element)
            }
        }
        return subArray
    }

    func ip_passesTest(@noescape test: (element: Element) -> Bool) -> Bool {
        for ob in self {
            if test(element: ob) {
                return true
            }
        }
        return false
    }
}

public extension Array where Element: Equatable {
    mutating func ip_remove(objectToRemove: Element) -> Bool {
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
    func ip_toSet() -> Set<Element> {
        return Set(self)
    }
}
