import Foundation

protocol WebManagerProtocol: AnyObject {
    func executeNonAuthorized<WebDTOModel: Codable>(webRequest: WebRequest) async throws -> WebDTOModel
}

protocol DataLoadingProtocol: AnyObject {
    func loadData(from url: URL) async throws -> Data
}

final class WebManager {
    static let shared = WebManager(
        requestFactory: RequestFactory(jsonEncoder: JSONConverterEncoder()),
        jsonDecoder: JSONConverterDecoder(),
        errorManager: ErrorManager(),
        environment: WebEnvironment.current
    )

    private let requestFactory: RequestFactoryProtocol
    private let jsonDecoder: JSONConverterDecoderProtocol
    private let errorManager: ErrorManagerProtocol
    private let urlSession: URLSession
    private let environment: WebEnvironment

    init(
        requestFactory: RequestFactoryProtocol,
        jsonDecoder: JSONConverterDecoderProtocol,
        errorManager: ErrorManagerProtocol,
        environment: WebEnvironment
    ) {
        self.requestFactory = requestFactory
        self.jsonDecoder = jsonDecoder
        self.errorManager = errorManager
        self.environment = environment

        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.httpAdditionalHeaders = [:]
        self.urlSession = URLSession(configuration: config)
    }
}

extension WebManager: WebManagerProtocol {
    func executeNonAuthorized<WebDTOModel: Codable>(webRequest: WebRequest) async throws -> WebDTOModel {
        let httpRequest = try requestFactory.buildHTTPRequest(environment: environment, webRequest: webRequest)
        let data = try await performRequest(httpRequest)
        return try jsonDecoder.decode(WebDTOModel.self, from: data) 
    }
}

extension WebManager: DataLoadingProtocol {
    func loadData(from url: URL) async throws -> Data {
        let (data, response) = try await urlSession.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.internalError(.badResponse)
        }
        return data
    }
}

private extension WebManager {
    func performRequest(_ urlRequest: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.internalError(.badResponse)
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw errorManager.handleHTTPStatusCode(data: data, statusCode: httpResponse.statusCode)
            }

            return data
        } catch let apiError as APIError {
            throw apiError
        } catch let urlError as URLError {
            throw errorManager.handleURLError(urlError)
        } catch {
            throw APIError.common(.unknown(error))
        }
    }
}
