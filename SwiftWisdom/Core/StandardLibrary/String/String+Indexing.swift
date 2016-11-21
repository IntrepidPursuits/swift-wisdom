import Foundation

extension String {

    public subscript(range: Range<Int>) -> String {
        let chars = Array(characters)
        let substringCharacters = chars[range]
        return String(substringCharacters)
    }

    public subscript(range: CountableClosedRange<Int>) -> String {
        let chars = Array(characters)
        let substringCharacters = chars[range]
        return String(substringCharacters)
    }

    public mutating func ip_dropFirst() {
        guard !isEmpty else { return }
        self = self[1..<characters.count]
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
        return NSRange(location: 0, length: ip_length);
    }
}
