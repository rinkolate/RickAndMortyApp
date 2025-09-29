import Foundation

enum ProfileDataFlow {
    enum LoadProfile {
        struct Request: Equatable {
            let id: Int?
        }

        struct ViewModelSuccess {
            let biography: BiographyModel
            let episodes: [EpisodesModel]
        }

        struct ViewModelFailure {
            let message: String
        }
    }
}
//enum ProfileDataFlow {
//    enum LoadEpisodes {
//        struct Request: Equatable {
//            let episodeUrls: [String] // Изменяем на URLs эпизодов
//        }
//        struct ViewModelSuccess {
//            let episodes: [EpisodesModel]
//        }
//        struct ViewModelFailure {
//            let message: String
//        }
//    }
//}
