// TODO 6: Use for-in loops with different collections

//for in with arrays

var array = [1,4,6,3,3,2]
// using indexes

for item in 0..<4 {
  print("at \(item) array has \(array[item])")
}
// using values

for item in array{
  print(item)
}

// for- in with dictionaries

var  dict: [String : String] =  [
"India": "New Delhi",
"China": "Hongkong",
"Usa": "Washington"
]

for (country,capital) in dict{
  print(country, "-", capital)
}
// to access the keys  in dictionary

for country in dict.keys{
  print(country)
}

//to access values in dictionary

for capital in dict.values{
print(capital)
}

// use of for-in in set

let set : Set<Int> = [2,3,1,5,7]
for item in set{
   print(item)
 }

//Create a function that processes both arrays and dictionaries


func processCollection<T>(_ collection: T) {
    if let array = collection as? [Any] {
        print("Processing an array:")
        for (index, element) in array.enumerated() {
            print("Index \(index): \(element)")
        }
    } else if let dictionary = collection as? [AnyHashable: Any] {
        print("Processing a dictionary:")
        for (key, value) in dictionary {
            print("Key: \(key), Value: \(value)")
        }
    } else {
        print("Unsupported type: \(type(of: collection))")
}
}
processCollection([2: "a",3:"b",4:"c",1:"d"])

