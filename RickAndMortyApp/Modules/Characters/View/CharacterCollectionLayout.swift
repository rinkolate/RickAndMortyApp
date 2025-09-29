import UIKit

struct CharacterCollectionLayout {
    func createCharacterLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection in
            self.createSection()
        }
    }


    private func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )

        group.interItemSpacing = .fixed(16)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16

        section.contentInsets = NSDirectionalEdgeInsets(
            top: 20,
            leading: 16,
            bottom: 20,
            trailing: 16
        )

        return section
    }
}
