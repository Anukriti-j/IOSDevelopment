// TODO 10: Create a class with properties, methods, and inheritance

class Intern{
  var internId : Int
  var internName : String
  init(internId: Int, internName: String){
    self.internId = internId
    self.internName = internName
  }
   func mentorship(mentorName: String){
     print("I am \(internName) , my id is \(internId), my mentor is \(mentorName)")
        }
   }

var fresher = Intern(internId: 101, internName: "Anukriti")
 fresher.mentorship(mentorName: "Kinjal")

// Inheritance

class FullTime: Intern{
  func promotion(_ salary :Int){
    print("\(internId), \(internName) got promoted with salary \(salary)")
  }
}

let emp1 = FullTime(internId: 101, internName: "anukriti")
emp1.promotion(30000)
