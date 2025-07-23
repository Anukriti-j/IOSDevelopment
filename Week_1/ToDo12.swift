// TODO 12: Create an enumeration with methods and associated values

enum TechStack{
  case ios(deviceName: String)
  case android(deviceName: String)
  case experience(year: Int)
  
  func training(){
    switch self {
      case .ios(let name):
      print(name)
      case .android(let name):
        print(name)
      default:
      print("not working")
    }
  }
}
 let item1 = TechStack.ios(deviceName: "Macos")
 item1.training() // changes made as per suggestion 
