// TODO 4: Implement a function that uses if-let for optional binding

//The function should take an optional string and return a greeting or default message

func optionalBinding(_ name: String?) -> String?{
  if let greeting = name{
    return "Hello, \(greeting) Good Job!"
  }else{
    return "hello Default User"
  }
}

let optionalCheck = optionalBinding(nil)
print(optionalCheck ?? "")
