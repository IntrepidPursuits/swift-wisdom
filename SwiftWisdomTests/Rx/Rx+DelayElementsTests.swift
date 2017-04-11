//
//  Rx+DelayElementsTests.swift
//  SwiftWisdom
//
//  Created by Son Le on 1/30/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import SwiftWisdom

final class RxDelayElementsTests: XCTestCase {

    func testDelayingElementsGreaterThanPredicate() {
        let bag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        let observable =
            scheduler.createColdObservable([
                next(0, 0),
                next(1, 1),
                next(2, 2),
                next(3, 3),
                next(4, 4)
            ])
            .ip_delayElements(
                matching: { $0 >= 2 },
                by: 2,
                scheduler: scheduler
            )
        let observer = scheduler.createObserver(Int.self)
        observable.bind(to: observer) >>> bag
        scheduler.start()

        let correctEvents: [Recorded<Event<Int>>] = [
            Recorded(time: 0, value: .next(0)),
            Recorded(time: 1, value: .next(1)),
            Recorded(time: 4, value: .next(2)),
            Recorded(time: 5, value: .next(3)),
            Recorded(time: 6, value: .next(4))
        ]
        for event in observer.events {
            XCTAssert(correctEvents.contains { $0 == event })
        }
    }

    func testDelayingElementsModPredicate() {
        let bag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        let observable =
            scheduler.createColdObservable([
                next(0, 0),
                next(1, 1),
                next(2, 2),
                next(3, 3),
                next(4, 4)
            ])
            .ip_delayElements(
                matching: { $0 % 2 == 0 },
                by: 2,
                scheduler: scheduler
            )
        let observer = scheduler.createObserver(Int.self)
        observable.bind(to: observer) >>> bag
        scheduler.start()

        let correctEvents: [Recorded<Event<Int>>] = [
            Recorded(time: 1, value: .next(1)),
            Recorded(time: 2, value: .next(0)),
            Recorded(time: 3, value: .next(3)),
            Recorded(time: 4, value: .next(2)),
            Recorded(time: 6, value: .next(4))
        ]
        for event in observer.events {
            XCTAssert(correctEvents.contains { $0 == event })
        }
    }
}
