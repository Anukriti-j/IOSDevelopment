// TODO 8: Create a function that takes another function as parameter
//Implement a function that applies an operation to each element in an array

// same function but here used guard let for optional binding

func calculateSum(_ arrNumbers: [Int], _ count: Int)-> (min: Int, max: Int, sum: Int,avg:
 Int){
   guard !arrNumbers.isEmpty else{
     return (0,0,0,0)
   }
   let min = arrNumbers.min()!
   let max = arrNumbers.max()!
   var sum = 0
   for num in arrNumbers{
     sum += num
   }
  let avg = sum/count
    return (min, max, sum, avg)
 }
print(calculateSum([2,4,1,6,5,0], 6))
