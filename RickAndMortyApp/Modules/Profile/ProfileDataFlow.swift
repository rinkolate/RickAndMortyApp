import Foundation

enum ProfileDataFlow {
    enum LoadEpisodes {
        struct Request: Equatable {
        }
        struct ViewModelSuccess {
            let episodes: [EpisodesModel]
        }
        struct ViewModelFailure {
            let message: String
        }
    }
}
