// TODO 15: Create a protocol and implement it in different types. Use mutating method
protocol Engine{
var startSpeed: Int{get set}  //property in protocol must have {get} or {get set}
func accelerate(_ speed:Int)->Int
}
// Conforming to class
class ElectricVehicle: Engine{
    var startSpeed = 0
    func accelerate(_ speed: Int)-> Int{
        return startSpeed + speed
    }
}
let ev = ElectricVehicle()
print(ev.accelerate(100))

// // Conforming to Struct 

protocol Engine{
    var startSpeed: Int{get set}
    mutating func accelerate()->Int
}
struct Vehicle: Engine{
    var startSpeed = 0
    mutating func accelerate()-> Int{
    startSpeed += 100
        return startSpeed
    }
}
var veh = Vehicle()
print(veh.accelerate())

// Protocol extension
extension Engine{
    mutating func brake()-> Int{
    startSpeed -= 10
        return startSpeed
    }
}
print(veh.brake())
