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
public func <- <T>(property: AnyObserver<T>, variable: Observable<T>) -> Disposable {
    return variable
        .observeOn(MainScheduler.instance)
        .bindTo(property)
}

@warn_unused_result(message="http://git.io/rxs.uo")
public func <- <T>(property: AnyObserver<T>, variable: Variable<T>) -> Disposable {
    return property <- variable.asObservable()
}

@warn_unused_result(message="http://git.io/rxs.uo")
public func <- <T>(variable: Variable<T>, property: ControlProperty<T>) -> Disposable {
    return property.subscribeNext({ variable.value = $0 })
}

public func >>> (disposable: Disposable, disposeBag: DisposeBag) {
    disposeBag.addDisposable(disposable)
}

public func >>> (disposable: Disposable, compositeDisposable: CompositeDisposable) {
    compositeDisposable.addDisposable(disposable)
}

//  Operators.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//  https://github.com/ReactiveX/RxSwift/blob/master/RxExample/RxExample/Operators.swift
@warn_unused_result(message="http://git.io/rxs.uo")
public func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
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
