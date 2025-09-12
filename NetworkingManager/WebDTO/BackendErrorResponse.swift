import Foundation

public extension WebDTO {
    struct BackendErrorResponse: Codable, CustomStringConvertible {
        public let code: Int
        public let message: String

        public var description: String {
            return "Error code: \(code), message: \(message)"
        }

        public init(code: Int, message: String) {
            self.code = code
            self.message = message
        }
    }
}

