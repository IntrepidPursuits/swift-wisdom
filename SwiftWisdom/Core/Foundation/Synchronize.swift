//
//  Synchronize.swift
//  bmap
//
//  Created by Logan Wright on 12/7/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

public func synchronize(_ lock: AnyObject, closure: Block) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}
