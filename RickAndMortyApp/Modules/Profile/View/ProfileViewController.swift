import UIKit
import SafariServices

protocol ProfileDisplayLogic: AnyObject {
    @MainActor
    func displayProfileSuccess(with viewModel: ProfileDataFlow.LoadProfile.ViewModelSuccess)
    @MainActor
    func displayProfileFailure(with viewModel: ProfileDataFlow.LoadProfile.ViewModelFailure)
}

final class ProfileViewController: UIViewController {
    lazy var contentView: DisplaysProfile = {
        let view = ProfileView()
        view.onEpisodeTap = { [weak self] episodeName in
            self?.openVKVideoSearch(for: episodeName)
        }
        return view
    }()

    var presenter: ProfilePresentationLogic?
    var context: Int?

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.presentProfile(by: ProfileDataFlow.LoadProfile.Request(id: context))
    }

    private func openVKVideoSearch(for episodeName: String) {
        let searchQuery = "Rick and Morty \(episodeName)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "Rick%20and%20Morty"

        let vkVideoURLString = "https://m.vkvideo.ru/?q=\(searchQuery)&action=search"
        print(vkVideoURLString)

        guard let url = URL(string: vkVideoURLString) else {
            print("Invalid URL: \(vkVideoURLString)")
            return
        }

        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .rickGreen
        present(safariVC, animated: true)
    }
}

extension ProfileViewController: ProfileDisplayLogic {
    func displayProfileSuccess(with viewModel: ProfileDataFlow.LoadProfile.ViewModelSuccess) {
        contentView.setupProfile(bio: viewModel.biography, episodes: viewModel.episodes)
    }

    func displayProfileFailure(with viewModel: ProfileDataFlow.LoadProfile.ViewModelFailure) {
        let alert = UIAlertController(title: "Error", message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
