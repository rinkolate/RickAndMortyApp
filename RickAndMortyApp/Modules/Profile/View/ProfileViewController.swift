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
        contentView.setupProfile(bio: viewModel.biography, episodes: array)
    }
    
    func displayProfileFailure(with viewModel: ProfileDataFlow.LoadProfile.ViewModelFailure) {
        print(viewModel.message)
    }
}

let array: [EpisodesModel] = []

