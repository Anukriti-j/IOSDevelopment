// TODO 13: Create a structure with methods

struct Incrementer{
  var count: Int
  mutating func incrementing()-> Int{
    count += 1
    return count
  }
}
var obj = Incrementer(count: 1)
let currentCount = obj.incrementing()
print(currentCount)
