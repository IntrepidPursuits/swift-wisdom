import XCTest
import SwiftWisdom

class DateExtensionTests: XCTestCase {
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "EST")
        formatter.dateFormat = "M/d/y h:mm a"
        return formatter
    }()
    
    lazy var dateToTest: Date? = self.formatter.date(from: "2/19/1989 4:40 pm")
    lazy var dateToTest2000: Date? = self.formatter.date(from: "11/20/2013 4:40 pm")
    var nilDate: Date?
    
    override func setUp() {
        super.setUp()
        nilDate = nil
    }
    
    func testLongDateExtension() {
        let longDate = "February 19, 1989"
        let longDate2000 = "November 20, 2013"
        
        XCTAssertEqual(dateToTest?.ip_longDateString, longDate)
        XCTAssertEqual(dateToTest2000?.ip_longDateString, longDate2000)
        XCTAssertNil(nilDate?.ip_longDateString)
    }
    
    func testShortDateExtension() {
        let shortDate = "2.19.1989"
        let shortDate2000 = "11.20.2013"
        
        XCTAssertEqual(dateToTest?.ip_shortDateString, shortDate)
        XCTAssertEqual(dateToTest2000?.ip_shortDateString, shortDate2000)
        XCTAssertNil(nilDate?.ip_longDateString)
    }
    
    func testTimeStampDateExtension() {
        let timeStampDate = "2.19.1989 4:40 PM"
        let timeStampDate2000 = "11.20.2013 4:40 PM"
        
        XCTAssertEqual(dateToTest?.ip_timeStampString, timeStampDate)
        XCTAssertEqual(dateToTest2000?.ip_timeStampString, timeStampDate2000)
        XCTAssertNil(nilDate?.ip_longDateString)
    }
}
