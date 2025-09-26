import Foundation
import NetworkingManager

protocol ProfilePresentationLogic {
    func presentProfile(by viewModel: ProfileDataFlow.LoadProfile.Request)
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
    func presentProfile(by viewModel: ProfileDataFlow.LoadProfile.Request) {
        Task {
            do {
                guard let id = viewModel.id else {
                    await handleError("ID персонажа не указан")
                    return
                }

                let profile = try await provider.fetchProfile(by: id)
                let episodeIds = extractEpisodeIds(from: profile.episode)
                let episodes = try await loadEpisodes(ids: episodeIds)
                let biography = createBiography(from: profile)

                let successViewModel = ProfileDataFlow.LoadProfile.ViewModelSuccess(
                    biography: biography,
                    episodes: episodes
                )

                await viewController?.displayProfileSuccess(with: successViewModel)

            } catch {
                await handleError("Ошибка загрузки: \(error.localizedDescription)")
            }
        }
    }

    private func extractEpisodeIds(from episodeUrls: [String]) -> [Int] {
        return episodeUrls.compactMap { urlString in
            guard let url = URL(string: urlString),
                  let episodeId = Int(url.lastPathComponent) else {
                return nil
            }
            return episodeId
        }
    }

    private func loadEpisodes(ids: [Int]) async throws -> [EpisodesModel] {
        guard !ids.isEmpty else { return [] }
        return try await provider.fetchEpisodes(ids: ids)
    }

    private func createBiography(from profile: WebDTO.Character) -> BiographyModel {
        return BiographyModel(
            photo: profile.image,
            name: profile.name,
            status: profile.status,
            species: profile.species,
            type: profile.type.isEmpty ? "None" : profile.type,
            gender: profile.gender,
            origin: profile.origin.name
        )
    }

    private func handleError(_ message: String) async {
        let failureViewModel = ProfileDataFlow.LoadProfile.ViewModelFailure(message: message)
        await viewController?.displayProfileFailure(with: failureViewModel)
    }
}
