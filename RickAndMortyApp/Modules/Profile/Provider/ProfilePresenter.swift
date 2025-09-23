import Foundation

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
                    return
                }
                let profile = try await provider.fetchProfile(by: id)
                let biography = BiographyModel(
                    photo: profile.image,
                    name: profile.name,
                    status: profile.status,
                    species: profile.species,
                    type: profile.type,
                    gender: profile.gender,
                    origin: profile.origin.name
                )
                await viewController?.displayProfileSuccess(with: ProfileDataFlow.LoadProfile.ViewModelSuccess(biography: biography))
            } catch {
                let errorMessage = "Error: \(error.localizedDescription)"
                await viewController?.displayProfileFailure(with: ProfileDataFlow.LoadProfile.ViewModelFailure(message: errorMessage))
            }
        }
    }
}
