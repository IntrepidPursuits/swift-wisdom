//
//  DataIteratorTests.swift
//  SwiftWisdom
//
//  Created by Paul Rolfe on 11/11/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class DataSegmentIteratorTests: XCTestCase {
    
    let dataPath = Bundle(for: DataSegmentIteratorTests.self)
        .path(forResource: "mock_firmware_update", ofType: ".dfu")!
    
    lazy var originalData: Data = try! Data(contentsOf: URL(fileURLWithPath: self.dataPath))
    
    let segmentLength = 100
    
    func testIterator() {
        let generator = originalData.ip_segmentIterator(chunkLength: segmentLength)
        
        var reassembly = Data()
        while let next = generator.next(), next.count <= segmentLength {
            reassembly.append(next)
        }
        
        XCTAssert(reassembly == originalData)
    }
    
    func testIteratorSuffix() {
        let suffixStartPoints = [0, 500, 1235, 89999, 123042]
        
        suffixStartPoints.forEach { startPoint in
            let compareSuffix = originalData.ip_suffix(from: startPoint)
            
            let generator = originalData
                .ip_segmentIterator(start: startPoint, chunkLength: segmentLength)
            
            var reassembly = Data()
            while let next = generator.next(), next.count <= segmentLength {
                reassembly.append(next)
            }
            
            if let compareSuffix = compareSuffix {
                XCTAssert(reassembly == compareSuffix)
            } else {
                XCTAssert(reassembly.count == 0)
                XCTAssert(compareSuffix == nil)
            }
        }
    }
}

