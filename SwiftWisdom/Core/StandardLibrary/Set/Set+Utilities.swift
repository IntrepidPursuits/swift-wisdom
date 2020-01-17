public extension Set {
    func ip_toArray() -> [Element] {
        return [Element](self)
    }

    @available (*, unavailable, message: "use allSatisfy(_:) instead")
    func ip_passes(test: (Element) -> Bool) -> Bool {
        for ob in self {
            if test(ob) {
                return true
            }
        }
        return false
    }

    @available (*, unavailable, message: "use filter(_:) instead")
    func ip_filter(_ include: (Element) -> Bool) -> Set<Element> {
        var filtered = Set<Element>()
        for ob in self {
            if include(ob) {
                filtered.insert(ob)
            }
        }
        return filtered
    }
}

// MARK: Operator Overloads

extension Set {
    public static func += <T>(lhs: inout Set<T>, rhs: Set<T>) {
        lhs = lhs.union(rhs)
    }

    public static func -= <T>(lhs: inout Set<T>, rhs: Set<T>) {
        lhs = lhs.subtracting(rhs)
    }
}
