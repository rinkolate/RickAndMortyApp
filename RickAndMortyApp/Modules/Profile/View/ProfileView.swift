import Foundation
import UIKit

protocol DisplaysProfile: UIView {
    func setupProfile(bio: BiographyModel, episodes: [EpisodesModel])
}

final class ProfileView: UIView {
    typealias Snapshot = NSDiffableDataSourceSnapshot<ProfileSectionType, ProfileItem>
    typealias DataSource = UICollectionViewDiffableDataSource<ProfileSectionType, ProfileItem>
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, ProfileItem>
    typealias Header = UICollectionView.SupplementaryRegistration<ProfileSectionHeaderView>

    private lazy var dataSource = setupDataSource()
    private let collectionView: UICollectionView = {
        let collectionLayout = ProfileCollectionLayout()
        let layout = collectionLayout.createProfileLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .rickDarkBlue
        collectionView.contentInset.bottom = 86
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .rickDarkBlue
        addSubviews()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileView: DisplaysProfile {
    func setupProfile(bio: BiographyModel, episodes: [EpisodesModel]) {
        setupSnapshot(with: bio, episodes: episodes)
    }
}

private extension ProfileView {
    func addSubviews() {
        addSubview(collectionView)
    }

    func addConstraints() {
            collectionView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

    func setupDataSource() -> DataSource {
        let cellRegistration = createCellRegistration()
        let supplementaryRegistration = createSupplementaryRegistration()

        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }

        dataSource.supplementaryViewProvider = { collectionView, _, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration,
                for: indexPath
            )
        }

        return dataSource
    }

    func createSupplementaryRegistration() -> Header {
        Header(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, _, indexPath in
            let headerView = supplementaryView
            let label = self.headerTitle(for: indexPath.section)
            headerView.configure(text: label)
        }
    }

        func headerTitle(for index: Int) -> String? {
            guard let sectionType = ProfileSectionType(rawValue: index) else {
                return nil
            }
            switch sectionType {
            case .bio:
                return nil
            case .episodes:
                return "Episodes"
            }
    }

    func setupSnapshot(with biography: BiographyModel, episodes: [EpisodesModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.bio, .episodes])

        let bioItem = ProfileItem.biography(biography)
        let episodeItems = episodes.map { ProfileItem.episodes($0) }

        snapshot.appendItems([bioItem], toSection: .bio)
        snapshot.appendItems(episodeItems, toSection: .episodes)

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func createCellRegistration() -> CellRegistration {
        CellRegistration { [weak self] cell, _, item in
            guard let self = self else { return }
            switch item {
            case .biography(let model):
                cell.contentConfiguration = setupBiographyContentConfiguration(for: model)
            case .episodes(let model):
                cell.contentConfiguration = setupEpisodesContentConfiguration(for: model)
            }
        }
    }

    func setupBiographyContentConfiguration(for item: BiographyModel) -> BiographyContentConfiguration {
        return BiographyContentConfiguration(model: item)
    }

    func setupEpisodesContentConfiguration(for item: EpisodesModel) -> EpisodesContentConfiguration {
        return EpisodesContentConfiguration(model: item)
    }
}
