
import Foundation

extension UserDefaults {
    func setObjects<T: Codable>(_ object: T, forKey key: String) {
        if let encoded = try? JSONEncoder().encode(object) {
            self.set(encoded, forKey: key)
        }
    }
    
    func getObject<T: Codable>( _ type: T.Type, forKey key: String) -> T? {
        if let data = self.data(forKey: key) {
            if let decoded = try? JSONDecoder().decode(type, from: data) {
                return decoded
            }
        }
        return nil
    }
    
}
