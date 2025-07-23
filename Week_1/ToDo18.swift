// TODO 18: Use do-catch to handle errors

enum NetworkError: Error{
    case internetIssue
    case invalidUrl
}
 func dataRequest(_ url: String) throws {
     if url == "" {
         throw NetworkError.internetIssue
     }
 }
 do{
     try dataRequest("")
     print("valid request")
 }catch{
     print("invalid request")
 }
