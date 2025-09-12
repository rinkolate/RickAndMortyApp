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
    let episodeUrls: [String] // Добавляем поле для хранения URLs эпизодов

    init(from character: Character) {
        self.id = character.id
        self.name = character.name
        self.image = character.image
        self.status = character.status
        self.species = character.species
        self.episodeUrls = character.episode // Сохраняем URLs эпизодов
    }

    init(id: Int, name: String, image: String, status: String? = nil, species: String? = nil, episodeUrls: [String] = []) {
        self.id = id
        self.name = name
        self.image = image
        self.status = status
        self.species = species
        self.episodeUrls = episodeUrls
    }
}
