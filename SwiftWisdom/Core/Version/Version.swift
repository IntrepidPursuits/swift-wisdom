//
//  Version.swift
//  bmap
//
//  Created by Logan Wright on 11/30/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

public struct Version {
    public private(set) var major: Int = 0
    public private(set) var minor: Int = 0
    public private(set) var patch: Int = 0
    
    public init?(string: String) {
        let components = string
            .components(separatedBy: ".")
        guard components.count > 0, let major = Int(components[0]) else { return nil }
        self.major = major
        
        guard components.count > 1, let minor = Int(components[1]) else { return nil }
        self.minor = minor
        
        guard components.count > 2, let patch = Int(components[2]) else { return nil }
        self.patch = patch
    }
}

extension Version : CustomStringConvertible {
    public var description: String {
        return "\(major).\(minor).\(patch)"
    }
}

extension Version : Equatable {}

public func ==(lhs: Version, rhs: Version) -> Bool {
    guard lhs.major == rhs.major else { return false }
    guard lhs.minor == rhs.minor else { return false }
    guard lhs.patch == rhs.patch else { return false }
    return true
}

public func !=(lhs: Version, rhs: Version) -> Bool {
    return !(lhs == rhs)
}

extension Version : Comparable {}

public func < (lhs: Version, rhs: Version) -> Bool {
    if lhs.major != rhs.major {
        return lhs.major < rhs.major
    } else if lhs.minor != rhs.minor {
        return lhs.minor < rhs.minor
    } else {
        return lhs.patch < rhs.patch
    }
}

public func <= (lhs: Version, rhs: Version) -> Bool {
    return lhs < rhs || lhs == rhs
}

public func >= (lhs: Version, rhs: Version) -> Bool {
    return lhs > rhs || lhs == rhs
}

public func > (lhs: Version, rhs: Version) -> Bool {
    if lhs.major != rhs.major {
        return lhs.major > rhs.major
    } else if lhs.minor != rhs.minor {
        return lhs.minor > rhs.minor
    } else {
        return lhs.patch > rhs.patch
    }
}
