import UIKit

protocol ProfileDisplayLogic: AnyObject {
    func displayProfile(biography: BiographyModel, episodes: [EpisodesModel])
    func displayError(_ message: String)
}

final class ProfileViewController: UIViewController, ProfileDisplayLogic {
    var presenter: ProfilePresentationLogic?
    var selectedCharacter: CharacterModel?
    lazy var contentView: DisplaysProfile = ProfileView()

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let character = selectedCharacter {
            presenter?.presentProfile(character: character)
        } else {
            displayError("No character selected")
        }
    }

    func displayProfile(biography: BiographyModel, episodes: [EpisodesModel]) {
        contentView.setupProfile(bio: biography, episodes: episodes)
    }

    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
