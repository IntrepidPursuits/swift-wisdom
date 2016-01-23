//
//  NSData+ChunksTest.swift
//  bmap
//
//  Created by Logan Wright on 12/14/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class NSDataChunksTest: XCTestCase {
    
    func testChunks() {
        let longData = "aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa"
            .ip_dataFromHexadecimalString()!
        
        let equalChunks = longData
            .ip_equalChunksNoRemainder(chunkLength: 4)
        
        let equalChunksCount = equalChunks
            .filter { $0.length == 4 }
            .count
        
        XCTAssert(equalChunksCount == equalChunks.count)
        XCTAssert(equalChunksCount == 3)
        
        let overflowChunks = longData.ip_chunksWithRemainder(chunkLength: 4)
        
        XCTAssert(overflowChunks.last?.length == 3)
        XCTAssert(overflowChunks.count == 4)
    }
    
}
