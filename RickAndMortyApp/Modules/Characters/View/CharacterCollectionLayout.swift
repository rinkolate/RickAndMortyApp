//
//  CharacterCollectionLayout.swift
//  RickAndMortyApp
//
//  Created by Toshpulatova Lola on 07.09.2025.
//
import UIKit


struct CharacterCollectionLayout {
    func createCharacterLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection in
            self.createSection()
        }
    }
    private func createSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.48),
            heightDimension: .estimated(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(200)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(16)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = .init(
            top: 20,
            leading: 16,
            bottom: 20,
            trailing: 16
        )
        return section

    }

}
