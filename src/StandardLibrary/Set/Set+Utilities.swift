public func +=<T>(inout lhs: Set<T>, rhs: Set<T>) {
    lhs = lhs.union(rhs)
}

public func -=<T>(inout lhs: Set<T>, rhs: Set<T>) {
    lhs = lhs.subtract(rhs)
}

public extension Set {
    func ip_toArray() -> [Element] {
        return Array<Element>(self)
    }

    func ip_passesTest(@noescape test: (element: Element) -> Bool) -> Bool {
        for ob in self {
            if test(element: ob) {
                return true
            }
        }
        return false
    }

    func ip_remove(element: Element) -> Bool {
        var toSubtract = Set<Element>()
        for ob in self {
            if ob == element {
                toSubtract.insert(ob)
            }
        }
        subtract(toSubtract)
        return toSubtract.count > 0
    }

    func ip_filter(@noescape include: (element: Element) -> Bool) -> Set<Element> {
        var filtered = Set<Element>()
        for ob in self {
            if include(element: ob) {
                filtered.insert(ob)
            }
        }
        return filtered
    }
}
