import UIKit

//let jsonData: [String: Any] =
// [
// "id": 1,
// "title": "hello", 
// "completed": true
// ]
//
//struct Model: Codable {
//    let id: Int?
//    let title: String?
//    let completed: Bool?
//}
//
//
//let decoder = JSONDecoder()
//let decodedData = decoder.decode(Model.self, from: jsonData)
func something(){
    
}

class MyClass {
    var name: String
    var closure: (() -> Void)?
    
    init(name: String)  {
        self.name = name
        closure =  { [weak self] in
           // guard let self = self else { return }
            print("Hello, \(self?.name)")
        }
    }
    deinit {
        print("deinitialized: ✌️")
    }
}

var obj: MyClass? = MyClass(name: "Hello")
obj = nil
