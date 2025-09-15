import Foundation

protocol ProfilePresentationLogic {
    func presentProfile(character: CharacterModel)
}

final class ProfilePresenter {
    weak var viewController: ProfileDisplayLogic?
    let provider: ProvidesProfile

    init(viewController: ProfileDisplayLogic? = nil, provider: ProvidesProfile) {
        self.viewController = viewController
        self.provider = provider
    }
}

extension ProfilePresenter: ProfilePresentationLogic {
    func presentProfile(character: CharacterModel) {
        Task {
            do {
                let episodes = try await provider.fetchEpisodes(episodeUrls: character.episodeUrls)
                let biography = BiographyModel(from: character)

                await MainActor.run {
                    viewController?.displayProfile(biography: biography, episodes: episodes)
                }
            } catch {
                await MainActor.run {
                    viewController?.displayError(error.localizedDescription)
                }
            }
        }
    }
}
