import Foundation

protocol JSONConverterDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Codable
}

struct JSONConverterDecoder: JSONConverterDecoderProtocol {
    private let jsonDecoder = JSONDecoder()

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Codable {
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            throw APIError.internalError(.dataDecoding)
        }
    }
}

