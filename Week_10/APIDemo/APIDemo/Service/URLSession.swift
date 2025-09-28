import Foundation
import SwiftUI

class NewsAPIService {
    
    static let service = NewsAPIService()
    private init() {}
    
    func getData<T: Decodable>(from urlString: String, with param: [String: String]? = nil) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkErrors.invalidURL }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let param = param {
            components?.queryItems = param.map { URLQueryItem(name: $0.key, value: $0.value)}
        }
        
        guard let finalURL = components?.url else {
            throw NetworkErrors.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: finalURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkErrors.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkErrors.decodingError
        }
    }
}
