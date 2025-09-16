import Foundation
import NetworkingManager


protocol CharacterPresentationLogic {
    func presentCharacters(with response: CharacterDataFlow.LoadCharacters.Request)
}

final class CharacterPresenter {
    weak var viewController: CharacterDisplayLogic?
    let provider: ProvidesCharacter

    init(viewController: CharacterDisplayLogic? = nil, provider: ProvidesCharacter) {
        self.viewController = viewController
        self.provider = provider
    }
}

extension CharacterPresenter: CharacterPresentationLogic {
    func presentCharacters(with response: CharacterDataFlow.LoadCharacters.Request) {
        Task {
            do {
                let response = try await provider.fetchCharacters()
                let characters = response.results
                let mapCharacters = mapCharacterToViewModel(characters)
                await viewController?.displayCharactersSuccess(
                    with: CharacterDataFlow.LoadCharacters.ViewModelSuccess(characters: mapCharacters)
                    )
            } catch {
                let errorMessage = "Error: \(error.localizedDescription)"
                await viewController?.displayCharactersFailure(with: CharacterDataFlow.LoadCharacters.ViewModelFailure(message: errorMessage))
            }
        }
    }
}

private extension CharacterPresenter {

    func mapCharacterToViewModel(_ array: [WebDTO.Character]) -> [CharacterModel] {
        array.map { character in
            CharacterModel(
                id: character.id,
                name: character.name,
                image: character.image,
                status: character.status,
                species: character.species,
                type: character.type,
                gender: character.gender,
                origin: character.origin.name,
                episodeUrls: character.episode
            )
        }
    }
}
