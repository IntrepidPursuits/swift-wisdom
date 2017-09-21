//
//  Version.swift
//  bmap
//
//  Created by Logan Wright on 11/30/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

/// This attempts to (mostly) mirror the rules defined by semver.org
/// Note: Some exceptions are made to be more lenient.
/// A strict semver library can be found here: https://github.com/weekwood/Semver.Swift
public struct Version {
    public var major: Int = 0
    public var minor: Int = 0
    public var patch: Int = 0
    public var preRelease: String?
    public var metaData: String?

    /// The string used to initalize this instance.
    public let originalVersion: String?

    public init() {
        self.originalVersion = nil
    }

    /// Will fail to intialize if not a valid version according to http://semver.org/.
    ///
    /// Some leniency is provided:
    /// - Leading zeroes are allowed.
    /// - Non-alphanumeric characters are allowed in the preRelease and metaData
    /// - Version numbers beyond the patch are dropped (but still create a valid version)
    ///
    public init?(string: String) {
        self.originalVersion = string

        let components = string.components(separatedBy: ".")

        // Must have at least one component. 
        // Only integers allowed in the major, otherwise invalid.
        guard components.count > 0, let major = Int(components[0]) else { return nil }
        self.major = major

        if components.count > 1 {
            // Only integers allowed in the minor, otherwise invalid.
            if let minor = Int(components[1]) {
                self.minor = minor
            } else {
                return nil
            }
        }

        if components.count > 2 {
            // Everything after the second "." will be parsed together here, so we re-join them.
            let finalComponents = components[2..<components.count].joined(separator: ".")

            let patchComponents = finalComponents.components(separatedBy: CharacterSet(charactersIn: ".-+"))

            // Only integers allowed in the patch, otherwise invalid.
            if let patch = patchComponents.first, let number = Int(patch) {
                self.patch = number
            } else {
                return nil
            }

            // preRelease is anything after the "-" but before a perhaps nonexistent "+"
            if let preRelease = finalComponents.ip_suffix(from: "-")?.ip_prefix(upTo: "+") {
                self.preRelease = preRelease
            } else if let preRelease = finalComponents.ip_suffix(from: "-") {
                self.preRelease = preRelease
            }

            // metaData is anything after a perhaps nonexistent "+"
            if let metaData = finalComponents.ip_suffix(from: "+") {
                self.metaData = metaData
            }

            // Empty preRelease is invalid.
            if let preRelease = preRelease, preRelease.isEmpty {
                return nil
            }

            // Empty metaData is invalid.
            if let metaData = metaData, metaData.isEmpty {
                return nil
            }
        }
    }
}

extension Version: CustomStringConvertible {
    public var description: String {
        var version = "\(major).\(minor).\(patch)"
        if let preRelease = preRelease {
            version.append("-\(preRelease)")
        }
        if let metaData = metaData {
            version.append("+\(metaData)")
        }
        return version
    }

    /// Everything except the metaData, as it should not be counted in precedence.
    /// http://semver.org/#spec-item-10
    public var comparableDescription: String {
        var version = "\(major).\(minor).\(patch)"
        if let preRelease = preRelease {
            version.append("-\(preRelease)")
        } else {
            // nil preRelease should take precedence over any preRelease.
            // So we append "." to the comparison string to force that to be true.
            version.append(".")
        }
        return version
    }
}

// MARK: Operator Overloads

extension Version : Equatable {
    /// Metadata is considered when measuring equality.
    public static func == (lhs: Version, rhs: Version) -> Bool {
        return lhs.description == rhs.description
    }
}

extension Version : Comparable {
    /// Metadata is not considered when measuring precedence.
    public static func < (lhs: Version, rhs: Version) -> Bool {
        return lhs.comparableDescription.compare(rhs.comparableDescription, options: .numeric) == .orderedAscending
    }
}
