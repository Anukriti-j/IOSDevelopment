
// TODO 11: Add getter and setter properties

class Intern{
  var internId : Int
  var internName : String
  init(internId: Int, internName: String){
    self.internId = internId
    self.internName = internName
  }
  //computed property to add getter and setter
  
  var internNo : Int{
    get{
      return internId + 100
    }
    set(newValue){
      internId = newValue
    }
  }
func mentorship(mentorName: String){
  print("I am \(internName) , my id is \(internId), my mentor is \(mentorName)")
     
   }
}

var fresher = Intern(internId: 101, internName: "Anukriti")
fresher.mentorship(mentorName: "Kinjal")
print(fresher.internNo)
