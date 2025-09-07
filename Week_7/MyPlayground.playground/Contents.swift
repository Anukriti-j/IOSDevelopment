import Foundation
import PlaygroundSupport

//func getData() {
//    let session = URLSession.shared
//    let url = URL(string: "https://jsonplaceholder.typicode.com/users")
//    let task = session.dataTask(with: url!) { data, response, error in
//        if let nerror = error {
//            print("\(nerror.localizedDescription)")
//            return
//        }
//        guard let responseData = data else {
//            print("no data")
//            return
//        }
//        print(responseData)
//        if let response = response as? HTTPURLResponse {
//            print("\(response.statusCode)")
//        }
//        
//        do{
//            if let json = try JSONDecoder.decode() {
//                print("json response: \(json)")
//            }
//        } catch {
//            print("error parsing json")
//        }
//    }
//    task.resume()
//    
//}
//getData()

//
//func getData() {
//
//    guard let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=1") else {
//        print("invalid url")
//        return
//    }
//
//    let task = URLSession.shared.dataTask(with: url) { data, response, error in
//        if let error = error {
//            print("error: \(error.localizedDescription)")
//            return
//        }
//        guard let httpResponse = response as? HTTPURLResponse else {
//            print("invalid response")
//            return
//        }
//        guard (200...299).contains(httpResponse.statusCode) else {
//            print("server error \(httpResponse.statusCode)")
//            return
//        }
//        if let data = data, let jsonString = String(data: data, encoding: .utf8) {
//            print("succes \(jsonString)")
//        } else {
//            print("no data")
//        }
//    }
//    task.resume()
//}
//getData()
//func closure(action: () -> Void) {
//    print("before calling closure")
//    DispatchQueue.global().asyncAfter(deadline: .now() + 0) {
//        action()
//    }
//    print("after calling closure")
//}
//
//closure {
//    print("inside closure")
//}
//func getData() {
//    let url = "https://jsonplaceholder.typicode.com/comments?postId=1"
//    let urlObject = URL(string: url)
//    let session = URLSession.shared
//    
//    session.dataTask(with: urlObject!) { data, response, error in
//        if let nerror = error {
//            print("\(nerror.localizedDescription)")
//            return
//        }
//        guard let responseData = data else {
//            print("no data")
//            return
//        }
//        
//        do{
//            if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                print("json response: \(json)")
//            }
//        } catch {
//            print("error parsing json")
//        }
//    }.resume()
//}
//getData()

let familyJSON = """
{
    "familyname": "Jain",
    "members":   
    [   {
        "name": "Anukriti",
        "age": 22,
        "gender": "Female"
        },
        {
        "name": "Anukriti",
        "age": 22,
        "gender": "f",
        "role": "FTE"
        } 
    ]
}
"""

let eventJSON = """
    {
    "user_name": "Anukriti",
    "date": "2001-05-31",
    "website": "https://www.google.com"
    } 
    """

struct Event: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "user_name"
        case date = "date"
        case website = "website"
    }
    let name: String
    let date: Date
    let website: URL
}

let decoderD = JSONDecoder()
//decoder.dateDecodingStrategy = .secondsSince1970
//let formatter = DateFormatter()
//formatter.dateFormat = "yyyy-MM-dd"

//decoderD.dateDecodingStrategy = .formatted(formatter)
//decoder.keyDecodingStrategy = .convertFromSnakeCase

let eventData = eventJSON.data(using: .utf8)!
guard let events = try? decoderD.decode(Event.self, from: eventData) else {
    fatalError("decoding failed")
}
print(events.name)
print(events.date)
print(events.website)
        
//        
//struct Family: Decodable {
//    enum Gender: String, Decodable {
//        case Male, Female, other
//    }
//    struct Person: Decodable {
//        var ame: String
//        var age: Int
//        var gender: Gender?
//        var role: String?
//    }
//    var familyname: String
//    var members: [Person]
//}

//let decoder = JSONDecoder()
//let familyData = familyJSON.data(using: .utf8)!
//let myfamily = try! decoder.decode(Family.self, from: familyData)
//print(myfamily.familyname)
//
//for person in myfamily.members {
//    print(person.gender as Any)
//}

//import Foundation
//
//let eventJSON = """
//{
//    "user_name": "Anukriti",
//    "date": "27-01-2033",
//    "website": "https://www.google.com"
//} 
//"""
//
//struct Event: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case name = "user_name"
//        case date
//        case website
//    }
//    
//    let name: String
//    let date: Date
//    let website: URL
//}
//
//let decoder2 = JSONDecoder()
//let formatter2 = DateFormatter()
//formatter2.dateFormat = "dd-MM-yyyy"
//decoder2.dateDecodingStrategy = .formatted(formatter2)
//
//guard let eventData = eventJSON.data(using: .utf8),
//      let event = try? decoder2.decode(Event.self, from: eventData) else {
//    fatalError("Decoding failed")
//}

//print(event.name)    // Anukriti
//print(event.date)    // 2033-01-27 00:00:00 +0000
//print(event.website)
