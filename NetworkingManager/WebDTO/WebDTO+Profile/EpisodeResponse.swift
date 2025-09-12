public extension WebDTO {

    struct EpisodesResponse: Codable {
       public let info: Info
       public let results: [Episode]
    }

    struct Info: Codable {
       public let count: Int
       public let pages: Int
       public let next: String?
       public let prev: String?
    }

    struct Episode: Codable {
       public let id: Int
       public let name: String
       public let airDate: String
       public let episode: String
       public let characters: [String]
       public let url: String
       public let created: String

        enum CodingKeys: String, CodingKey {
                   case id
                   case name
                   case airDate = "air_date"
                   case episode
                   case characters
                   case url
                   case created
               }
    }

}
