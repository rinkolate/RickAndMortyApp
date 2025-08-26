//
//  EpisodesCollectionLayout.swift
//  RickAndMortyApp
//
//  Created by Mitina Ekaterina on 19.08.2025.
//

import UIKit

struct EpisodesCollectionLayout {

    func createEpisodesLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            self.createSection()
        }
    }

}

private extension EpisodesCollectionLayout {

    func createSection() -> NSCollectionLayoutSection {
        let fractionalWidth: CGFloat = 1.0
        let absoluteHeight: CGFloat = 86

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(fractionalWidth),
            heightDimension: .fractionalHeight(1.0)
        )

        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(fractionalWidth),
            heightDimension: .estimated(absoluteHeight)
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let padding: CGFloat = 16.0

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: padding,
            leading: padding,
            bottom: padding,
            trailing: padding
        )
        section.interGroupSpacing =  padding
        section.orthogonalScrollingBehavior = .none

        return section
    }

}
