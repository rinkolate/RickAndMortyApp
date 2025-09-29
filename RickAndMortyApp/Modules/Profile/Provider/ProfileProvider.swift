//import NetworkingManager
//import Foundation
//
//protocol ProvidesProfile {
//    func fetchProfile(by id: Int) async throws -> WebDTO.Character
////    func fetchEpisodes(episodeUrls: [String]) async throws -> [EpisodesModel]
//}
//
//struct ProfileProvider: ProvidesProfile {
//    
//    let service: ProfileServiceProtocol
//
//    func fetchProfile(by id: Int) async throws -> NetworkingManager.WebDTO.Character {
//        return try await service.getProfile(id: id)
//    }
//
////    func fetchEpisodes(episodeUrls: [String]) async throws -> [EpisodesModel] {
////        var episodes: [EpisodesModel] = []
////        for url in episodeUrls {
////            let episode = try await service.getEpisode(url: url)
////            episodes.append(EpisodesModel(from: episode))
////        }
////        return episodes
////    }
//}
// RickAndMortyApp/Modules/Profile/Provider/ProfileProvider.swift
import NetworkingManager
import Foundation

protocol ProvidesProfile {
    func fetchProfile(by id: Int) async throws -> WebDTO.Character
    func fetchEpisodes(ids: [Int]) async throws -> [EpisodesModel]
}

struct ProfileProvider: ProvidesProfile {
    let service: ProfileServiceProtocol

    func fetchProfile(by id: Int) async throws -> WebDTO.Character {
        return try await service.getProfile(id: id)
    }

    func fetchEpisodes(ids: [Int]) async throws -> [EpisodesModel] {
        guard !ids.isEmpty else {
            throw APIError.internalError(.dataEncoding) //пробрасываем эту ошибку для примера
        }

        let episodes = try await service.getEpisodes(ids: ids)
        return episodes.map { EpisodesModel(from: $0) }
    }
}
