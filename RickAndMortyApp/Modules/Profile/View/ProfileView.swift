import Foundation
import UIKit

protocol DisplaysProfile: UIView {
    func setupEpisodes(_ model: [EpisodesViewModel])
}

final class ProfileView: UIView {

    typealias Snapshot = NSDiffableDataSourceSnapshot<ProfileSectionType, ProfileItem>
    typealias DataSource = UICollectionViewDiffableDataSource<ProfileSectionType, ProfileItem>
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, ProfileItem>

    private lazy var dataSource = setupDataSource()

    private let collectionView: UICollectionView = {
        let episodesCollectionLayout = EpisodesCollectionLayout()
        let layout = episodesCollectionLayout.createEpisodesLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 4/255, green: 12/255, blue: 30/255, alpha: 1.0)
        collectionView.contentInset.bottom = 86
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 4/255, green: 12/255, blue: 30/255, alpha: 1.0)
        addSubviews()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView: DisplaysProfile {

    func setupEpisodes(_ model: [EpisodesViewModel]) {
        setupSnapshot(with: model)
    }

}

private extension ProfileView {

    func addSubviews() {
        addSubview(collectionView)
    }

    func addConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupDataSource() -> DataSource {
        let cellRegistration = createCellRegistration()
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
        return dataSource
    }

    func setupSnapshot(with model: [EpisodesViewModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.episodes])
        let items = model.map { model in
            ProfileItem.episodes(model)
        }
        snapshot.appendItems(items, toSection: .episodes)
        dataSource.apply(snapshot)
    }

    func createCellRegistration() -> CellRegistration {
        CellRegistration { [weak self] cell, _, item in
            guard let self = self else { return }
            switch item {
            case .episodes(let model):
                cell.contentConfiguration = setupEpisodesContentConfiguration(for: model)
            }
        }
    }

    func setupEpisodesContentConfiguration(for item: EpisodesViewModel) -> EpisodesContentConfiguration {
        let model = EpisodesViewModel(
            name: item.name,
            episodeNumber: item.episodeNumber,
            episodeSeason: item.episodeSeason,
            releaseDate: item.releaseDate
        )
        return EpisodesContentConfiguration(model: model)
    }

}
