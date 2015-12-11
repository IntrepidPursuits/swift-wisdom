//
//  Timeout.swift
//  bmap
//
//  Created by Logan Wright on 11/25/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import Foundation

internal class TimeoutOperation : NSOperation {
    let block: Block
    let duration: NSTimeInterval
    
    init(duration: NSTimeInterval = 30, block: Block) {
        self.duration = duration
        self.block = block
        super.init()
    }
    
    override func main() {
        After(duration) { [weak self] in
            if let cancelled = self?.cancelled, let block = self?.block where !cancelled {
                // TODO: This is on MAIN because of `After`, this should be clarified
                block()
            }
        }
    }
}
