
public extension Dictionary {
    public mutating func ip_setValue(_ val: AnyObject, forKeyPath keyPath: String) {
        var keys = keyPath.ip_keypathComponents()
        guard let first = keys.first as? Key else { print("Unable to use string as key on type: \(Key.self)"); return }
        keys.remove(at: 0)
        if keys.isEmpty, let settable = val as? Value {
            self[first] = settable
        } else {
            let rejoined = keys.joined(separator: ".")
            var subdict: [String : AnyObject] = [:]
            if let sub = self[first] as? [String : AnyObject] {
                subdict = sub
            }
            subdict.ip_setValue(val, forKeyPath: rejoined)
            if let settable = subdict as? Value {
                self[first] = settable
            } else {
                print("Unable to set value: \(subdict) to dictionary of type: \(type(of: self))")
            }
        }
        
    }
    
    public func ip_valueForKeyPath<T>(_ keyPath: String) -> T? {
        var keys = keyPath.ip_keypathComponents()
        guard let first = keys.first as? Key else { print("Unable to use string as key on type: \(Key.self)"); return nil }
        guard let value = self[first] else { return nil }
        keys.remove(at: 0)
        if !keys.isEmpty, let subDict = value as? [String : AnyObject] {
            let rejoined = keys.joined(separator: ".")
            return subDict.ip_valueForKeyPath(rejoined)
        }
        return value as? T
    }
}


private extension String {
    func ip_keypathComponents() -> [String] {
        return characters
            .split { $0 == "." }
            .map { String($0) }
    }
}
