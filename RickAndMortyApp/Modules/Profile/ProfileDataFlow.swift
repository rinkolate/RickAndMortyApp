import Foundation

enum ProfileDataFlow {
    enum LoadEpisodes {
        struct Request: Equatable {
        }
        struct ViewModelSuccess {
            let episodes: [EpisodesViewModel]
        }
        struct ViewModelFailure {
            let message: String
        }
    }
}
