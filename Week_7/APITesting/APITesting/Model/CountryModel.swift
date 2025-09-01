import Foundation

struct CountryResponse: Decodable {
    let error: Bool
    let msg: String
    let data: [Country]
}

struct Country: Decodable, Equatable, Identifiable {
    let id = UUID()
    let country: String
    let cities: [String]
}

