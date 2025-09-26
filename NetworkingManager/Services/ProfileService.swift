import Foundation

public protocol ProfileServiceProtocol {
    func getProfile(id: Int) async throws -> WebDTO.Character
    func getEpisodes(ids: [Int]) async throws -> [WebDTO.Episode]
}

public struct ProfileService: ProfileServiceProtocol {
    private let webManager: WebManagerProtocol

    public init() {
        self.webManager = WebManager.shared
    }

    public func getProfile(id: Int) async throws -> WebDTO.Character {
        return try await webManager.executeNonAuthorized(
            webRequest: WebRequest(
                method: .get,
                header: [WebRequest.Header(contentType: .applicationJson)],
                path: "/api/character/\(id)",
                query: nil,
                body: nil
            )
        )
    }

    public func getEpisodes(ids: [Int]) async throws -> [WebDTO.Episode] {
        var episodes: [WebDTO.Episode] = []

        for episodeId in ids {
            let episode = try await getSingleEpisode(id: episodeId)
            episodes.append(episode)
        }

        return episodes
    }

    private func getSingleEpisode(id: Int) async throws -> WebDTO.Episode {
        return try await webManager.executeNonAuthorized(
            webRequest: WebRequest(
                method: .get,
                header: [WebRequest.Header(contentType: .applicationJson)],
                path: "/api/episode/\(id)",
                query: nil,
                body: nil
            )
        )
    }
}
