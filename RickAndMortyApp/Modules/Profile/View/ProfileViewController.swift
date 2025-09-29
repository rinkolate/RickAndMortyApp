import UIKit

protocol ProfileDisplayLogic: AnyObject {
    @MainActor
    func displayProfileSuccess(with viewModel: ProfileDataFlow.LoadProfile.ViewModelSuccess)
    @MainActor
    func displayProfileFailure(with viewModel: ProfileDataFlow.LoadProfile.ViewModelFailure)
}

final class ProfileViewController: UIViewController {
    lazy var contentView: DisplaysProfile = ProfileView()
    var presenter: ProfilePresentationLogic?
    var context: Int?

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.presentProfile(by: ProfileDataFlow.LoadProfile.Request(id: context))
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
