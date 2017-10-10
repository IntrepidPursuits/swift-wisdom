import Foundation

extension String {

    public subscript(range: Range<Int>) -> String {
        let lowerBound = index(startIndex, offsetBy: range.lowerBound)
        let upperBound = index(startIndex, offsetBy: range.upperBound)
        let indexRange = lowerBound..<upperBound
        return String(self[indexRange])
    }

    public subscript(range: CountableRange<Int>) -> String {
        let lowerBound = index(startIndex, offsetBy: range.lowerBound)
        let upperBound = index(startIndex, offsetBy: range.upperBound)
        let indexRange = lowerBound..<upperBound
        return String(self[indexRange])
    }

    public subscript(range: CountableClosedRange<Int>) -> String {
        let lowerBound = index(startIndex, offsetBy: range.lowerBound)
        let upperBound = index(startIndex, offsetBy: range.upperBound)
        let indexRange = lowerBound...upperBound
        return String(self[indexRange])
    }

    /// Returns a substring in the given range.
    /// If the range is beyond the string's length, returns the substring up to its bounds.
    public subscript(ip_safely range: Range<Int>) -> String {
        if range.lowerBound < 0 {
            return self[ip_safely: 0..<range.upperBound]
        } else if range.upperBound > count {
            let newRange = range.lowerBound..<count
            return String(self[newRange])
        } else {
            return String(self[range])
        }
    }

    /// Returns a substring in the given range.
    /// If the range is beyond the string's length, returns the substring up to its bounds.
    public subscript(ip_safely range: CountableClosedRange<Int>) -> String {
        if range.lowerBound < 0 {
            return self[ip_safely: 0...range.upperBound]
        } else if range.upperBound >= count {
            let newRange = range.lowerBound...(count - 1)
            return String(self[newRange])
        } else {
            return String(self[range])
        }
    }

    public mutating func ip_dropFirst() {
        guard !isEmpty else { return }
        self = self[1..<count]
    }

    /// From http://stackoverflow.com/questions/25138339/nsrange-to-rangestring-index/32379600#32379600
    /// Returns a String range based on an NSRange
    ///
    /// - parameter range: The input NSRange
    ///
    /// - returns: The string range
    public func ip_range(from range: NSRange) -> Range<String.Index>? {
        guard range.location >= 0 else { return nil }
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from..<to
    }

    /// Returns a String range based on an Int range. It is up to the caller to ensure that the
    /// int range is not out of bounds.
    ///
    /// - parameter uncheckedRange: An unchecked range, meaning the range could be out of bounds.
    ///
    /// - returns: The string range
    public func ip_range(from uncheckedRange: ClosedRange<Int>) -> Range<String.Index> {
        let from = index(startIndex, offsetBy: uncheckedRange.lowerBound)
        let to = index(from, offsetBy: uncheckedRange.count)
        return from..<to
    }

    public var ip_fullrange: NSRange {
        return NSRange(location: 0, length: ip_length)
    }

    /// Returns a new string containing the characters of the String up to, but not including, the first occurrence of the given string.
    /// If the string is not found, nil is returned.
    public func ip_prefix(upTo string: String) -> String? {
        guard let range = self.range(of: string) else { return nil }
        return String(self[..<range.lowerBound])
    }

    /// Returns a new string containing the characters of the String from the end of the first occurrence of the given String.
    /// If the string is not found, nil is returned.
    public func ip_suffix(from string: String) -> String? {
        guard let range = self.range(of: string) else { return nil }
        return String(self[range.upperBound...])
    }

}
