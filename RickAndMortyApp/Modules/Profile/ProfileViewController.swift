import UIKit

protocol ProfileDisplayLogic: AnyObject {
    @MainActor
    func displayEpisodesSuccess(with viewModel: ProfileDataFlow.LoadEpisodes.ViewModelSuccess)
    @MainActor
    func displayEpisodesFailure(with viewModel: ProfileDataFlow.LoadEpisodes.ViewModelFailure)
}

final class ProfileViewController: UIViewController {

    var presenter: ProfilePresentationLogic!
    var selectedCharacter: CharacterModel?

    lazy var contentView: DisplaysProfile = ProfileView()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let character = selectedCharacter {
            // Используем URLs эпизодов из выбранного персонажа
            let request = ProfileDataFlow.LoadEpisodes.Request(episodeUrls: character.episodeUrls)
            presenter.presentEpisodes(with: request)
        } else {
            displayEpisodesFailure(with: ProfileDataFlow.LoadEpisodes.ViewModelFailure(message: "No character selected"))
        }
    }
}

extension ProfileViewController: ProfileDisplayLogic {
    func displayEpisodesSuccess(with viewModel: ProfileDataFlow.LoadEpisodes.ViewModelSuccess) {
        print("ProfileViewController: Displaying \(viewModel.episodes.count) episodes")

        contentView.setupEpisodes(viewModel.episodes)
    }
    
    func displayEpisodesFailure(with viewModel: ProfileDataFlow.LoadEpisodes.ViewModelFailure) {
        print("ProfileViewController: Error - \(viewModel.message)")

        print(viewModel.message)
    }

}
