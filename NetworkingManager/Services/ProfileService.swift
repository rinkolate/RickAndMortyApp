import Foundation

public protocol ProfileServiceProtocol {
    func getProfile(id: Int) async throws -> WebDTO.Character
}

public struct ProfileService: ProfileServiceProtocol {

    private let webManager: WebManagerProtocol

    public init() {
        self.webManager = WebManager.shared
    }

    public func getProfile(id: Int) async throws -> WebDTO.Character {
        return try await webManager.executeNonAuthorized(
            webRequest: WebRequest(
                method: .get,
                header: [WebRequest.Header(contentType: .applicationJson)],
                path: "/api/character/\(id)",
                query: nil,
                body: nil
            )
        )
    }
}


