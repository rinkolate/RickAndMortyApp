import UIKit
import NetworkingManager

protocol CharacterDisplayLogic: AnyObject {

    @MainActor
    func displayCharactersSuccess(with viewModel: CharacterDataFlow.LoadCharacters.ViewModelSuccess)
    @MainActor
    func displayCharactersFailure(with viewModel: CharacterDataFlow.LoadCharacters.ViewModelFailure)

}

final class CharacterViewController: UIViewController {

    var presenter: CharacterPresentationLogic!

    lazy var contentView: DisplaysCharacter = CharacterView()

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
        presenter.presentCharacters(with: CharacterDataFlow.LoadCharacters.Request())
    }


}

extension CharacterViewController: CharacterDisplayLogic {
    func displayCharactersSuccess(with viewModel: CharacterDataFlow.LoadCharacters.ViewModelSuccess) {
        contentView.setupCharacters(viewModel.characters)
    }

    func displayCharactersFailure(with viewModel: CharacterDataFlow.LoadCharacters.ViewModelFailure) {
        print(viewModel.message)
    }

}

//extension CharacterViewController {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedCharacter = characters[indexPath.item]
//
//        let episodeService = EpisodeService()
//        let profileProvider = ProfileProvider(service: episodeService)
//        let profileViewController = ProfileViewController()
//        let profilePresenter = ProfilePresenter(viewController: profileViewController, provider: profileProvider)
//        profileViewController.presenter = profilePresenter
//        profileViewController.selectedCharacter = selectedCharacter
//        profileViewController.title = selectedCharacter.name
//
//        navigationController?.pushViewController(profileViewController, animated: true)
//        collectionView.deselectItem(at: indexPath, animated: true)
//    }
//}
