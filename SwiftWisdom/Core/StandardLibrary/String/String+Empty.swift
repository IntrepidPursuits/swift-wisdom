import Foundation

extension Intrepid where Base: String {
    public func isEmptyOrWhitespace() -> Bool {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
}
