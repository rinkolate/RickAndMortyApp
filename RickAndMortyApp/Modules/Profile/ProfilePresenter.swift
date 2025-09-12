import Foundation

protocol ProfilePresentationLogic {
    func presentEpisodes(with response: ProfileDataFlow.LoadEpisodes.Request)
}

struct ProfilePresenter {

    private weak var viewController: ProfileDisplayLogic?
    private let provider: ProvidesProfile

    init(viewController: ProfileDisplayLogic, provider: ProvidesProfile) {
        self.viewController = viewController
        self.provider = provider
    }

}

extension ProfilePresenter: ProfilePresentationLogic {
    func presentEpisodes(with response: ProfileDataFlow.LoadEpisodes.Request) {
        Task {
            do {
                let episodes = try await provider.fetchEpisodes(episodeUrls: response.episodeUrls)
                print("ProfilePresenter: Successfully fetched \(episodes.count) episodes")
                await viewController?.displayEpisodesSuccess(with: ProfileDataFlow.LoadEpisodes.ViewModelSuccess(episodes: episodes))
            } catch {
                let errorMessage = "Error: \(error.localizedDescription)"
                print("ProfilePresenter: \(errorMessage)")
                await viewController?.displayEpisodesFailure(with: ProfileDataFlow.LoadEpisodes.ViewModelFailure(message: errorMessage))
            }
        }
    }
}
