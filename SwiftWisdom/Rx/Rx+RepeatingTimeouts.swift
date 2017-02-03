//
//  Rx+RepeatingTimeouts.swift
//  SwiftWisdom
//
//  Created by Son Le on 1/30/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import RxSwift

extension ObservableType {

    /**
     Creates a new observable sequence that emits the same elements as the source observable, while also emitting the
     given element whenever the source emits an element, then emits nothing within the specified amount of time.

     Note that unlike `timeout(_,scheduler:)` and `timeout(_,other:scheduler:)`, the returned observable does not
     terminate after a timeout.

     - parameter dueTime: Maximum duration between emissions before a timeout occurs.
     - parameter element: Element to be emitted when a timeout occurs.
     - parameter scehduler: Scheduler to run the timeout timer on.
     
     - returns: New observable sequence as described.
     */
    public func ip_repeatingTimeouts(
            interval dueTime: RxTimeInterval,
            element: E,
            scheduler: SchedulerType = MainScheduler.instance
        ) -> Observable<E> {
        return
            Observable.of(
                asObservable(),
                debounce(dueTime, scheduler: scheduler).map { _ in element }
            )
            .merge()
    }
}
