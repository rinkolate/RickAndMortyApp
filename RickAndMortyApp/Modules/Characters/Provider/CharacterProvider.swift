import Foundation
import NetworkingManager

protocol ProvidesCharacter {
    func fetchCharacters() async throws -> [CharacterModel]
}

struct CharacterProvider: ProvidesCharacter {
    let service: CharacterServiceProtocol

    func fetchCharacters() async throws -> [CharacterModel] {
        let response = try await service.getCharacters()
        return response.results.map { CharacterModel(from: $0) }
    }
}
