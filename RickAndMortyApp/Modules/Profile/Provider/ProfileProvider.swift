import NetworkingManager
import Foundation

protocol ProvidesProfile {
    func fetchEpisodes(episodeUrls: [String]) async throws -> [EpisodesModel]
}

struct ProfileProvider: ProvidesProfile {
    let service: EpisodeServiceProtocol

    func fetchEpisodes(episodeUrls: [String]) async throws -> [EpisodesModel] {
        var episodes: [EpisodesModel] = []
        for url in episodeUrls {
            let episode = try await service.getEpisode(url: url)
            episodes.append(EpisodesModel(from: episode))
        }
        return episodes
    }
}

