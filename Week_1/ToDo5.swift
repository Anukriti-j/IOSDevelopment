// TODO 5: Use a switch statement with multiple patterns
	
var status = "not pass"
switch status{
  case "pass":
  print("excellent")
  case "fail":
  print("Retry")
  default:
  print("Improve always")
}

//Create a function that categorizes a number based on different ranges



func categorization(_ number : Int?){
  guard let num = number else {
    print("no number found")
    return
  }
  switch num {
    case 1...10 :
      print("number in the range 1 to 10")
    case 11...20 :
        print("number in the range 11 to 20")
    case 21... :
          print("number in the range 21 and above")
    default:
    print("range not found")
  }
}
categorization(3)
