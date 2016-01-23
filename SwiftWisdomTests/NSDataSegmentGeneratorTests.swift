//
//  NSDataSegmentGeneratorTests.swift
//  bmap
//
//  Created by Logan Wright on 12/14/15.
//  Copyright © 2015 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class NSDataSegmentGeneratorTests: XCTestCase {

    let dataPath = NSBundle(forClass: NSDataSegmentGeneratorTests.self)
        .pathForResource("mock_firmware_update", ofType: ".dfu")!
    
    lazy var originalData: NSData = NSData(contentsOfFile: self.dataPath)!
    
    let segmentLength = 100

    func testGenerator() {
        let generator = originalData.ip_segmentGenerator(chunkLength: segmentLength)
        
        let reassembly = NSMutableData()
        while let next = generator.next() where next.length <= segmentLength {
            reassembly.appendData(next)
        }
        
        XCTAssert(reassembly == originalData)
    }

    func testGeneratorSuffix() {
        let suffixStartPoints = [0, 500, 1235, 89999, 123042]
        
        suffixStartPoints.forEach { startPoint in
            let compareSuffix = originalData.ip_suffixFrom(startPoint)
            
            let generator = originalData
                .ip_segmentGenerator(start: startPoint, chunkLength: segmentLength)

            let reassembly = NSMutableData()
            while let next = generator.next() where next.length <= segmentLength {
                reassembly.appendData(next)
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
