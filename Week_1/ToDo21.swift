// TODO 21: Create generic functions and types

func swapping<T>(_ val1: inout T, _ val2 : inout T){
    let a = val1
    val1 = val2
    val2 = a
}
var val1 = "Hello"
var val2 = "Hi"
var swapNum = swapping(&val1, &val2)
print(val1, val2)

// Generic Type

struct Stack<Element> {
    var collection: [Element] = []
    mutating func push(_ item: Element){
        collection.append(item)
    }

}
var stack = Stack<String>()
stack.push("Hello")
stack.push("hi")
print(stack)
