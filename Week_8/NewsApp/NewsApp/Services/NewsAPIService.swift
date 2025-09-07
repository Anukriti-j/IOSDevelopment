import Foundation

struct NewsAPIService {
    
    static func buildURL(endPoint: String, queryItems: [String: String] = [:]) -> URL? {
        var components = URLComponents(string: Constants.baseUrl + endPoint)
        var items = queryItems.map { URLQueryItem(name: $0.key , value: $0.value )}
        items.append(URLQueryItem(name: "apiKey", value: Constants.apiKey))
        components?.queryItems = items
        return components?.url
    }
    
    static func fetchHeadlines() async throws -> [Article] {
        guard let url = NewsAPIService.buildURL(endPoint: "top-headlines", queryItems: ["country": "us"]) else{
            throw APIError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.serverError
        }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(NewsResponse.self, from: data)
            return decoded.articles
        } catch {
            throw APIError.decodingError
        }
    }
}
