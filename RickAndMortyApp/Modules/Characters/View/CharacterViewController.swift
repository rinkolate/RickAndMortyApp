import UIKit
import NetworkingManager

protocol CharacterDisplayLogic: AnyObject {
    func displayCharacters(_ characters: [CharacterModel])
    func displayError(_ message: String)
}

final class CharacterViewController: UIViewController, CharacterDisplayLogic {
    var presenter: CharacterPresentationLogic?
    lazy var contentView: DisplaysCharacter = CharacterView()
    private var characters: [CharacterModel] = []
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = contentView as? UIView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1.0)
        setupActivityIndicator()
        setupCollectionViewSelectionHandler()
        presenter?.presentCharacters()
    }

    private func setupActivityIndicator() {
        activityIndicator.color = .white
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    func displayCharacters(_ characters: [CharacterModel]) {
        activityIndicator.stopAnimating()
        self.characters = characters
        contentView.setupCharacters(characters)
    }

    func displayError(_ message: String) {
        activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func setupCollectionViewSelectionHandler() {
        if let characterView = contentView as? CharacterView {
            characterView.collectionView.delegate = self
        }
    }
}

extension CharacterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCharacter = characters[indexPath.item]

        let episodeService = EpisodeService()
        let profileProvider = ProfileProvider(service: episodeService)
        let profileViewController = ProfileViewController()
        let profilePresenter = ProfilePresenter(viewController: profileViewController, provider: profileProvider)
        profileViewController.presenter = profilePresenter
        profileViewController.selectedCharacter = selectedCharacter
        profileViewController.title = selectedCharacter.name

        navigationController?.pushViewController(profileViewController, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
