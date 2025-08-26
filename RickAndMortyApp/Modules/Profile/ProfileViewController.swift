import UIKit

final class ProfileViewController: UIViewController {

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
        displayEpisodes()
    }

}

extension ProfileViewController {

    func displayEpisodes() {
        contentView.setupEpisodes(array)
    }

}
let array = [mock1, mock2, mock3, mock4, mock5, mock6, mock7, mock8, mock9, mock10, mock11]
fileprivate let mock1 = EpisodesViewModel(name: "name1", episodeNumber: "num1", episodeSeason: "season1", releaseDate: "date1")
fileprivate let mock2 = EpisodesViewModel(name: "name2", episodeNumber: "num2", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock3 = EpisodesViewModel(name: "name3", episodeNumber: "num3", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock4 = EpisodesViewModel(name: "name4", episodeNumber: "num4", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock5 = EpisodesViewModel(name: "name5", episodeNumber: "num5", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock6 = EpisodesViewModel(name: "name6", episodeNumber: "num2", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock7 = EpisodesViewModel(name: "name7", episodeNumber: "num2", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock8 = EpisodesViewModel(name: "name8", episodeNumber: "num2", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock9 = EpisodesViewModel(name: "name9", episodeNumber: "num2", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock10 = EpisodesViewModel(name: "name10", episodeNumber: "num10", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock11 = EpisodesViewModel(name: "name11", episodeNumber: "num11", episodeSeason: "season2", releaseDate: "date2")
