// TODO 20: Use defer to execute cleanup code

func resources(_ file: String){
    defer{
        print("file is closed")
    }
    print(" \(file) file is open")
}
var systemUse = resources("mySwift.png")
