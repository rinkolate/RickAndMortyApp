import Foundation

enum WebEnvironment {
    static let current = WebEnvironment.production

    case production
    case test
    case dev

    var apiBaseURL: String {
        switch WebEnvironment.current {
        case .production, .test, .dev:
            return "https://rickandmortyapi.com"
        }
    }
}
