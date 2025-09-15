import UIKit


struct ProfileCollectionLayout {
    func createProfileLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _  in
            guard let section = ProfileSectionType(rawValue: sectionIndex) else {
                return nil
            }
            switch section {
            case .bio:
                return self.createBiographySection()
            case .episodes:
                return self.createEpisodesSection()
            }
        }
    }

    private func createSection(height: CGFloat, headerHeight: CGFloat = 0) -> NSCollectionLayoutSection {
        let fractionalSize: CGFloat = 1.0

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(fractionalSize),
            heightDimension: .absolute(height)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: .zero, bottom: 24, trailing: .zero)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(fractionalSize),
            heightDimension: .absolute(height)
        )

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(16)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: .zero, leading: 16, bottom: 16, trailing: 16)

        if headerHeight > 0 {
            let supplementarySize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(fractionalSize),
                heightDimension: .absolute(headerHeight)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: supplementarySize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        }
        return section
    }

    private func createBiographySection() -> NSCollectionLayoutSection {
        createSection(height: 600)
    }

    private func createEpisodesSection() -> NSCollectionLayoutSection {
        createSection(height: 86, headerHeight: 22)
    }
}
