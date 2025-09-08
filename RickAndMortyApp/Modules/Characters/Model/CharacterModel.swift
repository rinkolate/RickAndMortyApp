//
//  CharacterModel.swift
//  RickAndMortyApp
//
//  Created by Toshpulatova Lola on 07.09.2025.
//

import Foundation

struct CharacterModel: Hashable {
    let id: Int
    let name: String
    let image: String
    let status: String?
    let species: String?

    init(from character: Character) {
        self.id = character.id
        self.name = character.name
        self.image = character.image
        self.status = character.status
        self.species = character.species
    }

    init(id: Int, name: String, image: String, status: String? = nil, species: String? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.status = status
        self.species = species
    }
}
