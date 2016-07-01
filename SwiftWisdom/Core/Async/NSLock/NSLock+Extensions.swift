//
//  NSLock+Extensions.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 7/1/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import Foundation

extension NSLock {
    public func ip_locked(@noescape closure: () throws -> Void) rethrows {
        lock()
        defer { unlock() }
        try closure()
    }
}
