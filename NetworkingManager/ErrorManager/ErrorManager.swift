import Foundation

protocol ErrorManagerProtocol {
    func handleHTTPStatusCode(data: Data?, statusCode: Int) -> APIError
    func handleURLError(_ error: URLError) -> APIError
}

struct ErrorManager: ErrorManagerProtocol {
    func handleHTTPStatusCode(data: Data?, statusCode: Int) -> APIError {
            switch statusCode {
            case 401:
                return .backend(.unauthorized)
            case 408:
                return .backend(.requestTimeout)
            case 500:
                if let data = data, let backendError = parseBackendError(data) {
                    return .backend(.background(backendError))
                }
                return .backend(.httpFailed(statusCode))
            default:
                return .common(
                    .unknown(
                        NSError(domain: "Backend", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                    )
                )
            }
        }

    func handleURLError(_ error: URLError) -> APIError {
        switch error.code {
        case .timedOut:
            return .backend(.requestTimeout)
        case .notConnectedToInternet:
            return .internalError(.networkUnavailable)
        case .unsupportedURL:
            return .internalError(.invalidURL)
        default:
            return .common(.unknown(error))
        }
    }
}


private extension ErrorManager {
    func parseBackendError(_ data: Data) -> WebDTO.BackendErrorResponse? {
        do {
            let jsonDecoder = JSONConverterDecoder()
            return try jsonDecoder.decode(WebDTO.BackendErrorResponse.self, from: data)
        } catch {
            return nil
        }
    }
}
