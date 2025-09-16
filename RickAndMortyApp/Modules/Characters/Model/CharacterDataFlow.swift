import Foundation

enum CharacterDataFlow {
    enum LoadCharacters {
        struct Request: Equatable {
        }
        struct ViewModelSuccess {
            let characters: [CharacterModel]
        }
        struct ViewModelFailure {
            let message: String
        }
    }
}
