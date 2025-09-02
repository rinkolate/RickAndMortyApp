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

    func presentEpisodes(with response: ProfileDataFlow.LoadEpisodes.Request) { Task {
        do {
            let response = try await provider.fetchEpisodes()
            //тут будет маппинг
            await viewController?.displayEpisodesSuccess(with: ProfileDataFlow.LoadEpisodes.ViewModelSuccess(episodes: response))
        } catch {
            let errorMessage = "Error: \(error.localizedDescription)"
            await viewController?.displayEpisodesFailure(with: ProfileDataFlow.LoadEpisodes.ViewModelFailure(message: errorMessage))
        }
    }}

}
