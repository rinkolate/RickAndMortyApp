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

        presenter.presentEpisodes(with: ProfileDataFlow.LoadEpisodes.Request())

        if let character = selectedCharacter {
            // Здесь можно загрузить реальные эпизоды для выбранного персонажа
            // Пока используем моковые данные
            presenter.presentEpisodes(with: ProfileDataFlow.LoadEpisodes.Request())
        } else {
            presenter.presentEpisodes(with: ProfileDataFlow.LoadEpisodes.Request())
        }
    }
}

extension ProfileViewController: ProfileDisplayLogic {
    func displayEpisodesSuccess(with viewModel: ProfileDataFlow.LoadEpisodes.ViewModelSuccess) {
        contentView.setupEpisodes(viewModel.episodes)
    }
    
    func displayEpisodesFailure(with viewModel: ProfileDataFlow.LoadEpisodes.ViewModelFailure) {
        print(viewModel.message)
    }

}
