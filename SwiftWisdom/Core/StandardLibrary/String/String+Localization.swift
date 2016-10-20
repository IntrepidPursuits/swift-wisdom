import Foundation

extension String {
    public func ip_localized(_ args: [CVarArg] = [], comment: String = "") -> String {
        let localizedFormat = NSLocalizedString(self, comment: comment)
        return String(format: localizedFormat, arguments: args)
    }
}
