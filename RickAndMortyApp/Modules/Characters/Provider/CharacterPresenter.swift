import Foundation


protocol CharacterPresentationLogic {
    func presentCharacters()
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
    func presentCharacters() {
        Task {
            do {
                let characters = try await provider.fetchCharacters()
                await MainActor.run {
                    viewController?.displayCharacters(characters)
                }
            } catch {
                await MainActor.run {
                    viewController?.displayError(error.localizedDescription)
                }
            }
        }
    }
}
