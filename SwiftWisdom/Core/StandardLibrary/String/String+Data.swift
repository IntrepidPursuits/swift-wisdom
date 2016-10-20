import Foundation

public extension String {
    public var ip_hexInt: UInt {
        return strtoul(self, nil, 16)
    }
}
