//
//  Rx+Extensions.swift
//  SwiftWisdom
//
//  Created by Logan Wright on 3/31/16.
//  Copyright © 2016 Intrepid. All rights reserved.
//

import RxSwift
import RxCocoa

precedencegroup Binding {
    associativity: left
    higherThan: Disposing
    lowerThan: AssignmentPrecedence
}

precedencegroup Disposing {
    associativity: left
}

infix operator <-> : Binding
infix operator <- : Binding
infix operator >>> : Disposing

public func <- <T: ObserverType, O: ObservableType>(observer: T, observable: O) -> Disposable where T.E == O.E {
    return observable.observeOn(MainScheduler.instance).bindTo(observer)
}

public func <- <T: ObserverType, O>(observer: T, variable: Variable<O>) -> Disposable where T.E == O {
    return observer <- variable.asObservable()
}

public func <- <T, O: ObservableType>(variable: Variable<T>, observable: O) -> Disposable where O.E == T {
    return observable.bindTo(variable)
}

public func <- <T>(observer: Variable<T>, observable: Variable<T>) -> Disposable {
    return observer <- observable.asObservable()
}

public func >>> (disposable: Disposable, disposeBag: DisposeBag) {
    disposeBag.insert(disposable)
}

public func >>> (disposable: Disposable, compositeDisposable: CompositeDisposable) {
    let _ = compositeDisposable.insert(disposable)
}

//  Operators.swift
//  RxExample
//
//  Created by Krunoslav Zaher on 12/6/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//  https://github.com/ReactiveX/RxSwift/blob/master/RxExample/RxExample/Operators.swift
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
    
    return Disposables.create(bindToUIDisposable, bindToVariable)
}
