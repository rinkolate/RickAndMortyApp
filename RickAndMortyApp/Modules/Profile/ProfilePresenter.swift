import Foundation

struct ProfilePresenter {

    private weak var viewController: ProfileDisplayLogic?

    init(viewController: ProfileDisplayLogic? = nil) {
        self.viewController = viewController
    }

}
