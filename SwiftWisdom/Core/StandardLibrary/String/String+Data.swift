import Foundation

extension Intrepid where Base: String {
    public var hexInt: UInt {
        return strtoul(base, nil, 16)
    }
}
