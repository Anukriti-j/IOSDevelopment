import UIKit

class SecondViewController: UIViewController {
    var receivedName: String?
    var receivedAge: Int?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var agelabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = receivedName{
            nameLabel.text = "UserName: \(name)"
        }else{
            nameLabel.text = "User name not found"
        }
        if let age = receivedAge{
            agelabel.text = "UserAge: \(age)"
        }else{
            agelabel.text = "User age not found"
        }
    }
}
