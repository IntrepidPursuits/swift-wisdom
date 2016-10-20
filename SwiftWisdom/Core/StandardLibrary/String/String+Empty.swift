import Foundation

extension String {
    public func ip_isEmptyOrWhitespace() -> Bool {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
}
