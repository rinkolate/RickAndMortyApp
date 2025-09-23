import UIKit

protocol DisplaysCharacter: UIView {

    var viewDelegate: CharacterViewDelegate? { get set }
    func setupCharacters(_ model: [CharacterModel])
    
}

protocol CharacterViewDelegate: AnyObject {
    func didSelectCharacter(_ id: Int)
}

final class CharacterView: UIView {

    typealias DataSource = UICollectionViewDiffableDataSource<CharacterSectionType, CharacterItemType>
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, CharacterItemType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CharacterSectionType, CharacterItemType>

    weak var viewDelegate: CharacterViewDelegate?

    private lazy var dataSource = setupDataSource()
    private var characters: [CharacterModel] = []

    let collectionView: UICollectionView = {
        let characterCollectionLayout = CharacterCollectionLayout()
        let layout = characterCollectionLayout.createCharacterLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .rickDarkBlue
        collectionView.delegate = self
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
        self.characters += model
        setupSnapshot(with: model)
    }

}

private extension CharacterView {

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

extension CharacterView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = self.characters[indexPath.row].id
        viewDelegate?.didSelectCharacter(id)
    }

}
