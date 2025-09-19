import UIKit

protocol DisplaysCharacter: UIView {

    func setupCharacters(_ model: [CharacterModel])
    func setupLoader(_ isEnabled: Bool)

}

final class CharacterView: UIView {

    typealias DataSource = UICollectionViewDiffableDataSource<CharacterSectionType, CharacterItemType>
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, CharacterItemType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CharacterSectionType, CharacterItemType>

    private lazy var dataSource = setupDataSource()

    let collectionView: UICollectionView = {
        let characterCollectionLayout = CharacterCollectionLayout()
        let layout = characterCollectionLayout.createCharacterLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .rickWhite
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .rickDarkBlue
        addSubviews()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CharacterView: DisplaysCharacter {

    func setupCharacters(_ model: [CharacterModel]) {
        setupSnapshot(with: model)
    }

    func setupLoader(_ isEnabled: Bool) {
        if isEnabled {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

}

private extension CharacterView {

    func addSubviews() {
        addSubview(collectionView)
        addSubview(activityIndicator)
    }

    func addConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setupDataSource() -> DataSource {
        let cellRegistration = createCellRegistration()

        return DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
    }

    func setupSnapshot(with model: [CharacterModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.character])
        let items = model.map { CharacterItemType.character($0) }
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }

    func createCellRegistration() -> CellRegistration {
            CellRegistration { [weak self] cell, _, item in
                guard let self = self else { return }
                switch item {
                case .character(let model):
                    cell.contentConfiguration = setupCharacterContentConfiguration(for: model)
                }
            }
        }

    func setupCharacterContentConfiguration(for model: CharacterModel) -> CharacterContentConfiguration {
        let model = CharacterModel(
            id: model.id,
            name: model.name,
            image: model.image,
            status: model.status,
            species: model.species,
            type: model.type,
            gender: model.gender,
            origin: model.origin,
            episodeUrls: model.episodeUrls
        )
        return CharacterContentConfiguration(model: model)
    }

}

