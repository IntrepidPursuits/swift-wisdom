//
//  NSDataSegmentGeneratorTests.swift
//  bmap
//
//  Created by Logan Wright on 12/14/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class NSDataSegmentIteratorTests: XCTestCase {

    let dataPath = Bundle(for: NSDataSegmentIteratorTests.self)
        .path(forResource: "mock_firmware_update", ofType: ".dfu")!
    
    lazy var originalData: NSData = try! NSData(contentsOf: URL(fileURLWithPath: self.dataPath))
    
    let segmentLength = 100

    func testIterator() {
        let generator = originalData.ip_segmentIterator(chunkLength: segmentLength)
        
        let reassembly = NSMutableData()
        while let next = generator.next() as? Data, next.count <= segmentLength {
            reassembly.append(next)
        }
        
        XCTAssert(reassembly == originalData)
    }

    func testIteratorSuffix() {
        let suffixStartPoints = [0, 500, 1235, 89999, 123042]
        
        suffixStartPoints.forEach { startPoint in
            let compareSuffix = originalData.ip_suffixFrom(startPoint)
            
            let generator = originalData
                .ip_segmentIterator(start: startPoint, chunkLength: segmentLength)

            let reassembly = NSMutableData()
            while let next = generator.next() as? Data, next.count <= segmentLength {
                reassembly.append(next)
            }
            
            if let compareSuffix = compareSuffix {
                XCTAssert(reassembly == compareSuffix)
            } else {
                XCTAssert(reassembly.length == 0)
                XCTAssert(compareSuffix == nil)
            }
        }
    }
}
