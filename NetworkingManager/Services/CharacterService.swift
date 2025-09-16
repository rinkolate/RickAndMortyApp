import Foundation

public protocol CharacterServiceProtocol {

    func getCharacters() async throws -> WebDTO.CharactersResponse

}

public struct CharacterService: CharacterServiceProtocol {

    private let webManager: WebManagerProtocol

    public init() {
        self.webManager = WebManager.shared
    }

    public func getCharacters() async throws -> WebDTO.CharactersResponse {
        return try await webManager.executeNonAuthorized(
            webRequest: WebRequest(
                method: .get,
                header: [WebRequest.Header(contentType: .applicationJson)],
                path: "/api/character",
                query: nil,
                body: nil
            )
        )
    }
}
