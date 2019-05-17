import Foundation

extension String {
    public func ip_localized(_ args: [CVarArg] = [], comment: String = "") -> String {
        //swiftlint:disable nslocalizedstring_key
        let localizedFormat = NSLocalizedString(self, comment: comment)
        //swiftlint:enable nslocalizedstring_key
        return String(format: localizedFormat, arguments: args)
    }
}
