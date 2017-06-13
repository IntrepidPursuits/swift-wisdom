//
//  Rx+String.swift
//  SwiftWisdom
//
//  Created by Maya Saxena on 6/12/17.
//  Copyright © 2017 Intrepid. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType where E == String {
    public func ip_limitLength(to limit: Int) -> Observable<E> {
        return self.map { $0.ip_trimmed(toLength: limit) }
    }
}

extension ObservableType where E == String? {
    public func ip_limitLength(to limit: Int) -> Observable<E> {
        return self.map { $0?.ip_trimmed(toLength: limit) }
    }
}

extension ControlPropertyType where E == String {
    public func ip_limited(toLength length: Int) -> ControlProperty<String> {
        let values: Observable<String> = asObservable().map { $0.ip_trimmed(toLength: length) }
        let valueSink: AnyObserver<String> = mapObserver { $0 }
        return ControlProperty<String>(values: values, valueSink: valueSink)
    }
}

extension Reactive where Base: UITextField {
    /** Limit the length of input to a text field

    Usage Example:

     textField.rx.ip_limitLength(to: 5)

    Note: This does not restrict length when the text property of the text field is modified directly e.g.

     textField.text = "A string over the limit"

     */
    public func ip_limitInputLength(to limit: Int) -> Disposable {
        return text.ip_limitLength(to: limit).bind(to: text)
    }
}
