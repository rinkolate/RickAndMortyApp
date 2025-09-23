import NetworkingManager
import Foundation

protocol ProvidesProfile {
    func fetchProfile(by id: Int) async throws -> WebDTO.Character
//    func fetchEpisodes(episodeUrls: [String]) async throws -> [EpisodesModel]
}

struct ProfileProvider: ProvidesProfile {
    
    let service: ProfileServiceProtocol

    func fetchProfile(by id: Int) async throws -> NetworkingManager.WebDTO.Character {
        return try await service.getProfile(id: id)
    }

//    func fetchEpisodes(episodeUrls: [String]) async throws -> [EpisodesModel] {
//        var episodes: [EpisodesModel] = []
//        for url in episodeUrls {
//            let episode = try await service.getEpisode(url: url)
//            episodes.append(EpisodesModel(from: episode))
//        }
//        return episodes
//    }
}

