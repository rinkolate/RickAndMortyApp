//
//  NetworkService.swift
//  RickAndMortyApp
//
//  Created by Toshpulatova Lola on 07.09.2025.
//
import Foundation
import NetworkingManager 


// NetworkService.swift
final class NetworkService {
    static let shared = NetworkService()
    private init() {}

    private let baseURL = "https://rickandmortyapi.com/api"

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/character") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        print("URL: \(url.absoluteString)")

        // Используем WebManager для загрузки данных
        Task {
            do {
                let data = try await WebManager.shared.loadData(from: url)
                let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
                print("Successfully fetched \(response.results.count) episodes")
                completion(.success(response.results))

            } catch {
                print("Error fetching episodes: \(error)")

                completion(.failure(error))
            }
        }
    }

    func fetchEpisodes(urls: [String], completion: @escaping (Result<[Episode], Error>) -> Void) {
        // Создаем группу операций для параллельной загрузки
        let group = DispatchGroup()
        var episodes: [Episode] = []
        var errors: [Error] = []

        for urlString in urls {
            guard let url = URL(string: urlString) else {
                continue
            }

            group.enter()
            Task {
                do {
                    let data = try await WebManager.shared.loadData(from: url)
                    let episode = try JSONDecoder().decode(Episode.self, from: data)
                    episodes.append(episode)
                } catch {
                    errors.append(error)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            if let firstError = errors.first {
                completion(.failure(firstError))
            } else {
                completion(.success(episodes))
            }
        }
    }
}

struct EpisodesResponse: Codable {
    let info: Info
    let results: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
