//
//  OperatorTests.swift
//  SwiftWisdom
//
//  Created by Benjamin Wu on 5/6/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import RxSwift
@testable import SwiftWisdom


class OperatorTests: XCTestCase {

    func testAddCompositeDisposable() {
        let compositeDisposable = CompositeDisposable()
        let observable = Observable<String>.never()
        XCTAssertEqual(0, compositeDisposable.count)
        UILabel().rx_text <- observable >>> compositeDisposable
        XCTAssertEqual(1, compositeDisposable.count)
    }

}
