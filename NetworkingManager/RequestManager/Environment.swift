import Foundation

enum WebEnvironment {
    static let current = WebEnvironment.production

    case production
    case test
    case dev

    var apiBaseURL: String {
        switch self {
        case .production, .test, .dev:
            return "https://rickandmortyapi.com"
        }
    }
}
