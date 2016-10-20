import XCTest
import RxSwift
import RxCocoa
@testable import SwiftWisdom


class OperatorTests: XCTestCase {

    func testAddCompositeDisposable() {
        let compositeDisposable = CompositeDisposable()
        let observable = Observable<String?>.never()
        XCTAssertEqual(0, compositeDisposable.count)
        UILabel().rx.text <- observable >>> compositeDisposable
        XCTAssertEqual(1, compositeDisposable.count)
    }

}
