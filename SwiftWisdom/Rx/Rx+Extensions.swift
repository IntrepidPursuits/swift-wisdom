//
//  Rx+Extensions.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 3/31/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import RxSwift
import RxCocoa

infix operator <-> {
precedence 110
}

infix operator <- {
precedence 110
}

infix operator >>> {
precedence 100
}

@warn_unused_result(message="http://git.io/rxs.uo")
func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    let bindToUIDisposable = variable
        .asObservable()
        .bindTo(property)
    let bindToVariable = property
        .subscribe(
            onNext: { n in
                variable.value = n
            },
            onCompleted:  {
                bindToUIDisposable.dispose()
            }
        )
    
    return StableCompositeDisposable.create(bindToUIDisposable, bindToVariable)
}

@warn_unused_result(message="http://git.io/rxs.uo")
func <- <T>(property: AnyObserver<T>, variable: Observable<T>) -> Disposable {
    return variable
        .observeOn(MainScheduler.instance)
        .bindTo(property)
}

@warn_unused_result(message="http://git.io/rxs.uo")
func <- <T>(property: AnyObserver<T>, variable: Variable<T>) -> Disposable {
    return property <- variable.asObservable()
}

@warn_unused_result(message="http://git.io/rxs.uo")
func <- <T>(variable: Variable<T>, property: ControlProperty<T>) -> Disposable {
    return property.subscribeNext({ variable.value = $0 })
}

func >>> (disposable: Disposable, disposeBag: DisposeBag) {
    disposeBag.addDisposable(disposable)
}
