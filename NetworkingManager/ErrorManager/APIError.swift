import Foundation

public enum APIError: Error {
    case backend(Backend)
    case internalError(Internal)
    case common(Common)

    public enum Backend: Error {
        case unauthorized
        case httpFailed(Int)
        case requestTimeout
        case background(WebDTO.BackendErrorResponse)
    }

    public enum Internal: Error {
        case badResponse
        case invalidRequest
        case invalidURL
        case networkUnavailable
        case dataEncoding
        case dataDecoding
        case keychainWriteFailure
        case keychainDeleteFailure
    }

    public enum Common: Error {
        case unknown(Error)
    }
}

