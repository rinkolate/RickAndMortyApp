import Foundation
import NetworkingManager

struct CharacterModel: Hashable {
    let id: Int
    let name: String
    let image: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: String
    let episodeUrls: [String]

    init(from character: WebDTO.Character) {
        self.id = character.id
        self.name = character.name
        self.image = character.image
        self.status = character.status
        self.species = character.species
        self.type = character.type.isEmpty ? "None" : character.type
        self.gender = character.gender
        self.origin = character.origin.name
        self.episodeUrls = character.episode
    }
}
