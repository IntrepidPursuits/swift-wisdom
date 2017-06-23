import Foundation

public enum PasswordRequirement {
    case specialCharacters(exclude: Bool)
    case numbers(exclude: Bool)
    case lowercase(exclude: Bool)
    case uppercase(exclude: Bool)
    case minimum(length: Int)
    case maximum(length: Int)

    var expression: String {
        switch self {
        case .specialCharacters:
            return ".*[^A-Za-z0-9].*"
        case .numbers:
            return ".*[0-9].*"
        case .lowercase:
            return ".*[a-z].*"
        case .uppercase:
            return ".*[A-Z].*"
        case .minimum(let length):
            return "^([^A-Za-z0-9]|[A-Z]|[a-z]|[0-9]){\(length >= 0 ? length : 0),}$"
        case .maximum(let length):
            return "^([^A-Za-z0-9]|[A-Z]|[a-z]|[0-9]){0,\(length)}$"
        }
    }

    var exclude: Bool {
        switch self {
        case .specialCharacters(let exclude):
            return exclude
        case .numbers(let exclude):
            return exclude
        case .lowercase(let exclude):
            return exclude
        case .uppercase(let exclude):
            return exclude
        default:
            return false
        }
    }
}

extension String {
    /**
     At a minimum emails need an @ and . with at least one character preceeding between and after.  The philosophy here
     is that email validation should primarily be handled by a confirmation email and that the user generally knows
     what they are inputting.  We are trying to prevent false-negatives.

     - returns: True if the string contains an @ followed by a . with characters before between and after.
     */
    public func ip_isValidEmail() -> Bool {
        return range(of: ".@.+\\..", options: .regularExpression) != nil
    }

    /**
     Validate if a password at least conforms to an array of requirements. For character types,
     requirments can define if they should be excluded or appear at least once. Minimum and maximum
     length are also requirment types. Does not define any expectation beyond what is in the array of
     requirements (i.e. this function will always return true if the password requirement array is empty)
     - parameter requirements: The PasswordRequirements object
     - returns: True if the string meets all of the requirments passed in
     */
    func ip_isValidPassword(requirements: [PasswordRequirement]) -> Bool {
        for requirement in requirements {
            let found = range(of: requirement.expression, options: .regularExpression) != nil
            if (!requirement.exclude && !found) || (requirement.exclude && found) {
                return false
            }
        }
        return true
    }
}
