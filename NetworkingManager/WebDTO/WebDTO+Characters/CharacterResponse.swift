public extension WebDTO {

    struct CharactersResponse: Codable {
        public let info: Info
        public let results: [Character]
    }

    struct Character: Codable, Identifiable {
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

    struct Location: Codable {
        public let name: String
        public let url: String
    }

}
