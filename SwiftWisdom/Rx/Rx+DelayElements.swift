//
//  Rx+DelayElements.swift
//  SwiftWisdom
//
//  Created by Son Le on 1/30/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import RxSwift

extension ObservableType {

    /**
     Delays elements from the source observable that match a given predicate.

     Every other element from the source is emitted immediately upon arrival.

     - parameter predicate: A closure that returns true if an element should be delayed.
     - parameter delayTime: Time before each matching element is emitted.
     - parameter scheduler: Scheduler to run the delay timer on.

     - returns: New observable sequence as described.
     */
    public func ip_delayElements(
            matching predicate: @escaping (E) -> Bool,
            by delayTime: RxTimeInterval,
            scheduler: SchedulerType = MainScheduler.instance
        ) -> Observable<E> {
        return
            Observable.of(
                filter(predicate).delay(delayTime, scheduler: scheduler),
                filter { !predicate($0) }
            )
            .merge()
    }
}
