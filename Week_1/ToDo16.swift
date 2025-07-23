// TODO 16: Create an extension that adds functionality to an existing type

extension Int{
    func isEven()-> Bool {
     return self % 2 == 0
    }
}
let num: Int = 8
print(num.isEven())
