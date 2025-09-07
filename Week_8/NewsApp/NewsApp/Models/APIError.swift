import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "invalid URL"
        case .decodingError:
            return "decoding error"
        case .serverError:
            return "server error"
        }
    }
}
