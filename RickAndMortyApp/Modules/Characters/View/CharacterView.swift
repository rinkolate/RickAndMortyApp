import UIKit

protocol DisplaysCharacter: AnyObject {
    func setupCharacters(_ model: [CharacterModel])
}

final class CharacterView: UIView {
    typealias DataSource = UICollectionViewDiffableDataSource<CharacterSectionType, CharacterItemType>
    typealias CellRegistration = UICollectionView.CellRegistration<CharacterCell, CharacterItemType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CharacterSectionType, CharacterItemType>

    let collectionView: UICollectionView
    private lazy var dataSource = setUpDataSource()

    override init(frame: CGRect) {
        let characterCollectionLayout = CharacterCollectionLayout()
        let layout = characterCollectionLayout.createCharacterLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear

        super.init(frame: frame)
        backgroundColor = .rickDarkBlue
        addSubviews()
        addConstraints()
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: "CharacterCell")
    }
}

extension CharacterView: DisplaysCharacter {
    func setupCharacters(_ model: [CharacterModel]) {
        setupSnapshot(with: model)
    }
}

private extension CharacterView {
    func setUpDataSource() -> DataSource {
        let cellRegistration = CellRegistration { cell, indexPath, item in
            switch item {
            case .character(let model):
                cell.configure(with: model)
            }
        }

        return DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item)
        }
    }

    func setupSnapshot(with model: [CharacterModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.character])
        let items = model.map { CharacterItemType.character($0) }
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }

    func addSubviews() {
        addSubview(collectionView)
    }

    func addConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

final class CharacterCell: UICollectionViewCell {
    func configure(with model: CharacterModel) {
        contentConfiguration = CharacterContentConfiguration(model: model)
    }
}
