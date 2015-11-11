
public func +=<T>(inout lhs: Set<T>, rhs: Set<T>) {
    lhs = lhs.union(rhs)
}

public func -=<T>(inout lhs: Set<T>, rhs: Set<T>) {
    lhs = lhs.subtract(rhs)
}

public extension Set {
    public func ip_toArray() -> [Element] {
        return Array<Element>(self)
    }
    
    public func ip_passesTest(@noescape test: (element: Element) -> Bool) -> Bool {
        for ob in self {
            if test(element: ob) {
                return true
            }
        }
        return false
    }
    
    public func ip_filter(@noescape include: (element: Element) -> Bool) -> Set<Element> {
        var filtered = Set<Element>()
        for ob in self {
            if include(element: ob) {
                filtered.insert(ob)
            }
        }
        return filtered
    }
}
