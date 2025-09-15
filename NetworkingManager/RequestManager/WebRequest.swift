import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct WebRequest {
    let method: HTTPMethod
    let header: [Header]
    let path: String
    let query: [String: Any]?
    let body: Codable?

    struct Header: RawRepresentable {
        var key: String { rawValue.key }
        var value: String { rawValue.value }

        let rawValue: (key: String, value: String)

        init(rawValue: (key: String, value: String)) {
            self.rawValue = rawValue
        }
    }
}

extension WebRequest.Header {
    enum ContentType: String {
        case applicationJson = "application/json"
    }

    init(contentType: ContentType) {
        self.init(rawValue: (key: "Content-Type", value: contentType.rawValue))
    }
}
