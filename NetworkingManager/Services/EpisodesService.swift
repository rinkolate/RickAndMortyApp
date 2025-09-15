import Foundation

public protocol EpisodeServiceProtocol {
    func getEpisode(url: String) async throws -> WebDTO.Episode
}

public struct EpisodeService: EpisodeServiceProtocol {
    private let webManager: WebManagerProtocol

    public init() {
        self.webManager = WebManager.shared
    }

    public func getEpisode(url: String) async throws -> WebDTO.Episode {
        guard let urlComponents = URLComponents(string: url),
              let path = urlComponents.path.components(separatedBy: "api/").last else {
            throw APIError.internalError(.invalidURL)
        }

        return try await webManager.executeNonAuthorized(
            webRequest: WebRequest(
                method: .get,
                header: [WebRequest.Header(contentType: .applicationJson)],
                path: "/api/\(path)",
                query: nil,
                body: nil
            )
        )
    }
}
