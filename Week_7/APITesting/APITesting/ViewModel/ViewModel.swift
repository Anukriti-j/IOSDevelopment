import Foundation

@MainActor
class ViewModel: ObservableObject {
    @Published var countries: [Country] = []
    func loadData() async throws {
        let endPoint = "https://countriesnow.space/api/v0.1/countries"
        guard let url = URL(string: endPoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do{
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(CountryResponse.self, from: data)
            self.countries = decodedResponse.data
        } catch {
            throw NetworkError.invalidData
        }
    }
}
