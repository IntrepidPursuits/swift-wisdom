//
//  Rx+RepeatingTimeoutsTests.swift
//  SwiftWisdom
//
//  Created by Son Le on 1/30/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import SwiftWisdom

final class RxRepeatingTimeoutsTests: XCTestCase {

    private enum TestElement {
        case element
        case timeout
    }

    func testTimeouts() {
        let bag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        let observable: Observable<TestElement> =
            scheduler.createColdObservable([
                next(8, .element),
                next(9, .element),
                next(15, .element),
                next(16, .element)
            ])
            .ip_repeatingTimeouts(
                interval: 5,
                element: .timeout,
                scheduler: scheduler
            )
        let observer = scheduler.createObserver(TestElement.self)
        observable.bindTo(observer) >>> bag
        scheduler.start()

        let correctEvents: [Recorded<Event<TestElement>>] = [
            Recorded(time: 8, value: .next(.element)),
            Recorded(time: 9, value: .next(.element)),
            Recorded(time: 14, value: .next(.timeout)),
            Recorded(time: 15, value: .next(.element)),
            Recorded(time: 16, value: .next(.element)),
            Recorded(time: 21, value: .next(.timeout))
        ]
        for event in observer.events {
            XCTAssert(correctEvents.contains { $0 == event })
        }
    }
}
