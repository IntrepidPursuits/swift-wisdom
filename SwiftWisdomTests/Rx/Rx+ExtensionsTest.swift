import XCTest
import RxSwift
import RxCocoa
@testable import SwiftWisdom


class OperatorTests: XCTestCase {

    func testVariableBinding() {
        let disposeBag = DisposeBag()
        let label = UILabel()
        let variable = Variable<String?>(nil)

        label.rx.text <- variable >>> disposeBag
        XCTAssertEqual(nil, label.text)

        variable.value = "hello"
        XCTAssertEqual("hello", label.text)

        variable.value = nil
        XCTAssertEqual(nil, label.text)
    }

    func testNonOptionalVariableBindingToOptionalObserver() {
        let disposeBag = DisposeBag()
        let label = UILabel()
        let variable = Variable<String>("")

        label.rx.text <- variable >>> disposeBag
        XCTAssertEqual("", label.text)

        variable.value = "hello"
        XCTAssertEqual("hello", label.text)
    }

    func testObserverBinding() {
        let disposeBag = DisposeBag()
        let button = UIButton()
        let observable = Observable<String?>.just("hello")
        XCTAssertEqual(nil, button.title(for: .normal))
        button.rx.title(for: .normal) <- observable >>> disposeBag
        XCTAssertEqual("hello", button.title(for: .normal))
    }

    func testBindingToVariable() {
        let disposeBag = DisposeBag()
        let sut = Variable<String>("")
        let variable = Variable<String>("hello")

        sut <- variable >>> disposeBag
        XCTAssertEqual(variable.value, sut.value)
        XCTAssertEqual("hello", sut.value)

        variable.value = "world"
        XCTAssertEqual(variable.value, sut.value)
    }

    func testAddCompositeDisposable() {
        let compositeDisposable = CompositeDisposable()
        let observable = Observable<String?>.never()
        XCTAssertEqual(0, compositeDisposable.count)
        UILabel().rx.text <- observable >>> compositeDisposable
        XCTAssertEqual(1, compositeDisposable.count)
    }
    
    func testBehaviorRelayBinding() {
        let disposeBag = DisposeBag()
        let label = UILabel()
        let behaviorRelay = BehaviorRelay<String?>(value: nil)
        
        label.rx.text <- behaviorRelay >>> disposeBag
        XCTAssertEqual(nil, label.text)
        
        behaviorRelay.accept("hello")
        XCTAssertEqual("hello", label.text)
        
        behaviorRelay.accept(nil)
        XCTAssertEqual(nil, label.text)
    }
    
    func testNonOptionalBehaviorRelayBindingToOptionalObserver() {
        let disposeBag = DisposeBag()
        let label = UILabel()
        let behaviorRelay = BehaviorRelay<String>(value: "")

        label.rx.text <- behaviorRelay >>> disposeBag
        XCTAssertEqual("", label.text)
        
        behaviorRelay.accept("hello")
        XCTAssertEqual("hello", label.text)
    }
    
    func testBindingToBehaviorRelay() {
        let disposeBag = DisposeBag()
        let sut = BehaviorRelay<String>(value: "")
        let behaviorRelay = BehaviorRelay<String>(value: "hello")

        sut <- behaviorRelay >>> disposeBag
        XCTAssertEqual(behaviorRelay.value, sut.value)
        XCTAssertEqual("hello", sut.value)

        behaviorRelay.accept("world")
        XCTAssertEqual(behaviorRelay.value, sut.value)
    }
    
    func testTwoWayBindingWithBehaviorRelay() {
        let disposeBag = DisposeBag()
        let textField = UITextField()
        let behaviorRelay = BehaviorRelay<String?>(value: nil)

        textField.rx.text <-> behaviorRelay >>> disposeBag
        behaviorRelay.accept("hello")
        XCTAssertEqual("hello", textField.text)
        
        textField.text = "world"
        textField.sendActions(for: .editingChanged)
        XCTAssertEqual("world", behaviorRelay.value)
    }
    
    func testTwoWayBindingWithVariable() {
        let disposeBag = DisposeBag()
        let textField = UITextField()
        let variable = Variable<String?>(nil)
        
        textField.rx.text <-> variable >>> disposeBag
        variable.value = "hello"
        XCTAssertEqual("hello", textField.text)
        
        textField.text = "world"
        textField.sendActions(for: .editingChanged)
        XCTAssertEqual("world", variable.value)
    }

}
