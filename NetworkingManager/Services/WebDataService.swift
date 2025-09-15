import Foundation

public protocol DataServiceProtocol {
    func getData(from url: URL) async throws -> Data
}

public struct DataService: DataServiceProtocol {
    private let webManager: DataLoadingProtocol

    public init() {
        self.webManager = WebManager.shared
    }

    public func getData(from url: URL) async throws -> Data {
        return try await webManager.loadData(from: url)
    }
}
