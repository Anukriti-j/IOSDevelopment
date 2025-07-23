// TODO 19: Use try? to convert errors to optionals

enum NetworkError: Error{
    case internetIssue
    case invalidUrl
}
 func dataRequest(_ url: String) throws {
     if url == "" {
         throw NetworkError.invalidUrl
     }
 }
 if let error = try? dataRequest(""){
     switch error as NetworkError{
         case .internetIssue:
 print("interetissue")
         case .invalidUrl:
         print("invalidUrl")
     }
 }else{
     print("success")
 }
