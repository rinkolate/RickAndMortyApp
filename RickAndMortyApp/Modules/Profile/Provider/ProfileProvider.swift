

protocol ProvidesProfile {
    func fetchEpisodes(episodeUrls: [String]) async throws -> [EpisodesModel]
}

struct ProfileProvider: ProvidesProfile {
    func fetchEpisodes(episodeUrls: [String]) async throws -> [EpisodesModel] {
        return try await withCheckedThrowingContinuation { continuation in
            NetworkService.shared.fetchEpisodes(urls: episodeUrls) { result in
                switch result {
                case .success(let episodes):
                    let models = episodes.map { EpisodesModel(from: $0) }
                    print("ProfileProvider: Successfully created \(models.count) episode models")
                    continuation.resume(returning: models)
                case .failure(let error):
                    print("ProfileProvider: Error - \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
