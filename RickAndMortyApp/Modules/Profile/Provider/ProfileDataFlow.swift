import Foundation

enum ProfileDataFlow {
    enum LoadEpisodes {
        struct Request: Equatable {
            let episodeUrls: [String] // Изменяем на URLs эпизодов
        }
        struct ViewModelSuccess {
            let episodes: [EpisodesModel]
        }
        struct ViewModelFailure {
            let message: String
        }
    }
}
