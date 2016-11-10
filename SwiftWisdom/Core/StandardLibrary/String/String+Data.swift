import Foundation

extension String {
    
    /**
     Convert a hex string to Data.  Mostly for testing
     
     - returns: data from the hex string
     */
    public func ip_dataFromHexadecimalString() -> Data? {
        let clean = lowercased().replacingOccurrences(of: " ", with: "")
        let allowed = CharacterSet.alphanumerics
        let trimmed = clean.trimmingCharacters(in: allowed.inverted)
        guard !trimmed.isEmpty && trimmed.characters.count.ip_isEven else { return nil }
        
        // everything ok, so now let's build NSData
        
        var data = Data(capacity: trimmed.characters.count / 2)
        
        for i in stride(from: 0, through: trimmed.characters.count - 2, by: 2) {
            let byteString = trimmed[i...i + 1]
            var byte = UInt8(byteString.ip_hexInt)
            data.append(&byte, count: MemoryLayout<UInt8>.size)
        }
        
        return data
    }
}

extension String {
    public var ip_utf8Data: Data? {
        return data(using: .utf8)
    }
}

extension String {
    public var ip_hexInt: UInt {
        return strtoul(self, nil, 16)
    }
    
    public var ip_intValue: Int? {
        return Int(self)
    }
    
    public func ip_contains(_ find: String) -> Bool {
        return self.range(of: find) != nil
    }
    
    public var ip_length: Int {
        return self.characters.count
    }
}
