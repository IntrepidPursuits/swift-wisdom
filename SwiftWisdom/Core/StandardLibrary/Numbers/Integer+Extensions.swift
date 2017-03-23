import Foundation

extension Integer {
    public var ip_isEven: Bool {
        return (self % 2) == 0
    }
    
    public var ip_isOdd: Bool {
        return !ip_isEven
    }
}

extension Integer where Self : _Strideable & Comparable, Self.Stride : SignedInteger  {
    public func ip_times(closure: (Void) -> Void) {
        precondition(self >= 0)
        (0..<self).forEach { _ in closure() }
    }
}

extension Integer {
    public func ip_toMagnitudeString(withDecimalPlaces decimalPlaces: Int = 1) -> String {

        guard self > 999 else { return "\(self)" }

        let units = ["K", "M", "B", "T", "Q"]

        let value = Double(toIntMax())

        var magnitude: Int = Int(log10(value) / 3.0) // the order of magnitude of our value in thousands

        // divide value by 1000^magnitude to get hundreds value, then round to desired decimal places
        var roundedHundredsValue = (value / pow(1000.0, Double(magnitude))).ip_round(toDecimalPlaces: decimalPlaces)

        // if rounding brings our display value over 1000, divide by 1000 and then bump the magnitude
        if roundedHundredsValue >= 1000 {
            roundedHundredsValue /= 1000.0
            magnitude += 1
        }

        // if our number exceeds our current magnitude system return the scientific notation
        let magnitudeSuffix = units[ip_safe: magnitude - 1] ?? "E\(magnitude * 3)"

        guard let valueFormatted = NumberFormatter.decimalFormatter.string(from: NSNumber(value: roundedHundredsValue)) else {
            return "\(roundedHundredsValue)\(magnitudeSuffix)"
        }

        return "\(valueFormatted)\(magnitudeSuffix)"
    }
}

extension NumberFormatter {
    fileprivate static var decimalFormatter: NumberFormatter {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        decimalFormatter.minimumFractionDigits = 0
        return decimalFormatter
    }
}

extension Integer {
    fileprivate var ip_data: Data {
        var copy = self
        return Data(bytes: &copy, count: MemoryLayout<Self>.size)
    }

    public var ip_bigEndianData: Data? {
        switch UInt32(CFByteOrderGetCurrent()) {
        case CFByteOrderLittleEndian.rawValue:
            return Data(self.ip_data.reversed())
        case CFByteOrderBigEndian.rawValue:
            return self.ip_data
        default:
            return nil
        }
    }

    public var ip_littleEndianData: Data? {
        switch UInt32(CFByteOrderGetCurrent()) {
        case CFByteOrderLittleEndian.rawValue:
            return self.ip_data
        case CFByteOrderBigEndian.rawValue:
            return Data(self.ip_data.reversed())
        default:
            return nil
        }
    }
}
