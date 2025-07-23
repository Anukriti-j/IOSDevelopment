// TODO 7: Create a function with multiple parameters and return values
//Function should calculate statistics for an array of numbers

// used nil coalescing operator to provide default values

func calculateSum(_ arrNumbers: [Int], _ count: Int)-> (Int, Int, Int, Int){
   let min = arrNumbers.min() ?? 0
   let max = arrNumbers.max() ?? 0
   var sum = 0
   for num in arrNumbers{
     sum += num
   }
let avg = sum/count
return (min, max, sum, avg)
 }
print(calculateSum([2,4,1,6,5,0], 6))
