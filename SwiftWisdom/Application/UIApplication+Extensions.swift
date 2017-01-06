import UIKit

enum OpenSettingsError: Error {
    case cannotOpenURL
}

extension UIApplication {
    public func ip_openSettingsApp() throws {
        guard let url = URL(string: UIApplicationOpenSettingsURLString), canOpenURL(url) else {
            throw OpenSettingsError.cannotOpenURL
        }
        openURL(url)
    }
}
