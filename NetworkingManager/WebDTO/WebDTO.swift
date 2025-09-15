import Foundation

public enum WebDTO {
    public struct CharactersResponse: Codable {
        public let info: Info
        public let results: [Character]
    }

    public struct Character: Codable, Identifiable {
        public let id: Int
        public let name: String
        public let status: String
        public let species: String
        public let type: String
        public let gender: String
        public let origin: Location
        public let location: Location
        public let image: String
        public let episode: [String]
        public let url: String
        public let created: String
    }

    public struct Location: Codable {
        public let name: String
        public let url: String
    }

    public struct Info: Codable {
        public let count: Int
        public let pages: Int
        public let next: String?
        public let prev: String?
    }

    public struct Episode: Codable {
        public let id: Int
        public let name: String
        public let airDate: String
        public let episode: String
        public let characters: [String]
        public let url: String
        public let created: String

        enum CodingKeys: String, CodingKey {
            case id, name, episode, characters, url, created
            case airDate = "air_date"
        }
    }

    public struct BackendErrorResponse: Codable, CustomStringConvertible {
        public let code: Int
        public let message: String

        public var description: String {
            return "Error code: \(code), message: \(message)"
        }
    }
}

