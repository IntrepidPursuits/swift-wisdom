import Foundation

extension Intrepid where Base: String {
    public func localized(_ args: [CVarArg] = [], comment: String = "") -> String {
        let localizedFormat = NSLocalizedString(self, comment: comment)
        return String(format: localizedFormat, arguments: args)
    }
}
