import Foundation

extension String {
    func removeTruncatedTag() -> String {
        return self.replacingOccurrences(of: #"\[\+\d+\schars\]"#, with: "", options: .regularExpression)
    }
}
