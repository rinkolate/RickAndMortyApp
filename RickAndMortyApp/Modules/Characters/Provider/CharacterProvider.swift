import Foundation
import NetworkingManager

protocol ProvidesCharacter {
    func fetchCharacters() async throws -> WebDTO.CharactersResponse
}

struct CharacterProvider: ProvidesCharacter {

    let service: CharacterServiceProtocol

    func fetchCharacters() async throws -> WebDTO.CharactersResponse {
        try await service.getCharacters()
    }
}
