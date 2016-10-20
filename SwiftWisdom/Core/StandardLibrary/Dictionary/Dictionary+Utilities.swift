//
//  Dictionary+Utilities.swift
//  SwiftWisdom
//

extension Dictionary {
    /// Sets a value within a dictionary
    ///
    /// - parameter value:   Value to be stored
    /// - parameter keypath: Keypath of where to store `value`
    public mutating func ip_set(value: AnyObject, forKeypath keypath: String) {
        var keys = keypath.ip_keypathComponents()
        guard let first = keys.first as? Key else { print("Unable to use string as key on type: \(Key.self)"); return }
        keys.remove(at: 0)
        if keys.isEmpty, let settable = value as? Value {
            self[first] = settable
        } else {
            let rejoined = keys.joined(separator: ".")
            var subdict: [String : AnyObject] = [:]
            if let sub = self[first] as? [String : AnyObject] {
                subdict = sub
            }
            subdict.ip_set(value: value, forKeypath: rejoined)
            if let settable = subdict as? Value {
                self[first] = settable
            } else {
                print("Unable to set value: \(subdict) to dictionary of type: \(type(of: self))")
            }
        }
        
    }
    
    /// Finds a value (if it exists) for a provided `keypath`
    ///
    /// - parameter keypath: The keypath to access
    ///
    /// - returns: The `value` if found, else returns `nil`
    public func ip_value<T>(forKeypath keypath: String) -> T? {
        var keys = keypath.ip_keypathComponents()
        guard let first = keys.first as? Key else { print("Unable to use string as key on type: \(Key.self)"); return nil }
        guard let value = self[first] else { return nil }
        keys.remove(at: 0)
        if !keys.isEmpty, let subDict = value as? [String : AnyObject] {
            let rejoined = keys.joined(separator: ".")
            return subDict.ip_value(forKeypath: rejoined)
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
