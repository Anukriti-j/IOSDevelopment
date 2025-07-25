import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        guard let name = nameText.text, !name.isEmpty else{
            showAlert(message: "Please enter a name")
            return
        }
        guard let age = ageText.text, !age.isEmpty else{
            showAlert(message: "Please enter an age")
            return
        }
        performSegue(withIdentifier: "toSecondScreen" , sender: nil)
    }
    func showAlert(message: String){
        let alert = UIAlertController(title: "Input Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    if message.contains("name") {
                        self.nameText.becomeFirstResponder()
                    } else if message.contains("age") { 
                        self.ageText.becomeFirstResponder()
                    }
                }
                alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "toSecondScreen"{
            if let destinationViewController = segue.destination as? SecondViewController{
                destinationViewController.receivedAge = Int(ageText.text ?? "")
                destinationViewController.receivedName = nameText.text
            }
        }
    }
}

