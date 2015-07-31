import Foundation

public extension Dictionary {
    mutating func ip_setValue(val: AnyObject, forKeyPath keyPath: String) {
        var keys = keyPath.componentsSeparatedByString(".")
        guard let first = keys.first as? Key else { print("Unable to use string as key on type: \(Key.self)"); return }
        keys.removeAtIndex(0)
        if keys.isEmpty, let settable = val as? Value {
            self[first] = settable
        } else {
            let rejoined = ".".join(keys)
            var subdict: [NSObject : AnyObject] = [:]
            if let sub = self[first] as? [NSObject : AnyObject] {
                subdict = sub
            }
            subdict.ip_setValue(val, forKeyPath: rejoined)
            if let settable = subdict as? Value {
                self[first] = settable
            } else {
                print("Unable to set value: \(subdict) to dictionary of type: \(self.dynamicType)")
            }
        }

    }

    func ip_valueForKeyPath<T>(keyPath: String) -> T? {
        var keys = keyPath.componentsSeparatedByString(".")
        guard let first = keys.first as? Key else { print("Unable to use string as key on type: \(Key.self)"); return nil }
        guard let value = self[first] as? AnyObject else { return nil }
        keys.removeAtIndex(0)
        if !keys.isEmpty, let subDict = value as? [String : AnyObject] {
            let rejoined = ".".join(keys)
            return subDict.ip_valueForKeyPath(rejoined)
        }
        return value as? T
    }
}
