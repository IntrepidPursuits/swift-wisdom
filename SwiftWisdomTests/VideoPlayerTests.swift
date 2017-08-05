//
//  VideoPlayerTests.swift
//  SwiftWisdom
//
//  Created by Alexander Persian on 4/12/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import XCTest
@testable import SwiftWisdom

class VideoPlayerTests: XCTestCase {

    func testVideoInEquality() {
        let testBundle = Bundle(for: type(of: self))
        guard
            let video1 = Video(fileName: "testvideoone", type: ".mp4", bundle: testBundle),
            let video2 = Video(fileName: "testvideotwo", type: ".mov", bundle: testBundle)
        else {
            XCTFail("Failed to initialize video objects")
            return
        }

        XCTAssertFalse(video1 == video2)
    }

    func testVideoEquality() {
        let testBundle = Bundle(for: type(of: self))
        guard
            let video1 = Video(fileName: "testvideoone", type: ".mp4", bundle: testBundle),
            let video2 = Video(fileName: "testvideoone", type: ".mp4", bundle: testBundle)
        else {
            XCTFail("Failed to initialize video objects")
            return
        }

        XCTAssertTrue(video1 == video2)
    }
}
