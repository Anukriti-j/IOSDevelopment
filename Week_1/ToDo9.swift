// TODO 9: Create and use closures

// Creating a closure and its use as a block of functionality

let createclosure = { (_ x: Int, _ y: Int)-> Int in 
return x + y
}
print(createclosure(10,20))

// Using closures as a parameter to a function

func salary(_ fix: Int, _ incentive: Int, increment: (Int, Int)-> Int)-> Int{
  var totalSalary = increment(fix, incentive)
  return totalSalary
}

let income = salary(11000, 1500){ fix, incentive in 
  return fix + incentive
}
print(income)


//Use closures with the map function and create a closure that captures values

//use closures with map function

let numbers = [2,4,5,3,5,8]

let incrementedNumbers = numbers.map({ (number) ->Int in 
 return number + 1
})
print(incrementedNumbers)
// use closure to capture values

func captureValue(_ value:Int) -> () -> Int{
  var seat = value
  var position = { ()-> Int in
  seat += 1
   return seat 
  }
  return position
}
var sitting = captureValue(10)
print(sitting())
print(sitting())
