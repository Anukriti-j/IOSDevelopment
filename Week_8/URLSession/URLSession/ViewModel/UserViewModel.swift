import Foundation

class UserViewModel: ObservableObject{
    var userModel: UserModel?
    
    func getuser(completion: @escaping (Result<UserModel, Error>) -> Void) {
        let endpoint = "https://jsonplaceholder.typicode.com/users"
        
        APIManager.shared.request(endpoint: endpoint, method: "GET") { [weak self](result: Result<UserModel, Error>) in
            switch result{
            case .success(let userModel):
                self?.userModel = userModel
                completion(.success(userModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

