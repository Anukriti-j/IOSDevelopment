import Foundation

class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func request<UserModel: Codable>(endpoint: String, method: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        let url = URL(string: endpoint)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else {
                debugPrint("invalid response")
                return
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(UserModel.self, from: data)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                }
            }
            else {
                if let error = error {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
