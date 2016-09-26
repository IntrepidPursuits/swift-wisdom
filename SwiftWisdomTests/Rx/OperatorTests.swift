//
//  OperatorTests.swift
//  SwiftWisdom
//
//  Created by Benjamin Wu on 5/6/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
@testable import SwiftWisdom


class OperatorTests: XCTestCase {

    func testAddCompositeDisposable() {
        let compositeDisposable = CompositeDisposable()
        let observable = Observable<String?>.never()
        XCTAssertEqual(0, compositeDisposable.count)
        let _ = UILabel().rx.text <- observable >>> compositeDisposable
        XCTAssertEqual(1, compositeDisposable.count)
    }

}
