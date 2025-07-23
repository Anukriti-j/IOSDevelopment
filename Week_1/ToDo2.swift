// TODO 2: Work with arrays and dictionaries

//Create an array of your favorite foods and a dictionary of country capitals

var  arr: [String] = ["pizza", "cake", "Chole bhature"]
var  dict: [String : String] =  [
	"India": "New Delhi",
	"China": "Hongkong",
	"Usa": "Washington"
]
print("Old array:\n",arr)
print("old dictionary:\n", dict)
//Add a new item to the array and update a value in the dictionary

arr.append("IceCream")
dict["India"] = "Mumbai"
print("new array:\n",arr)
print("new dictionary:\n",dict)
