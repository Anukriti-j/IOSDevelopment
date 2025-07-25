import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var greetingMsg: UILabel?
    @IBOutlet weak var primaryButton: UIButton?
    @IBOutlet weak var inputName: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    private func setupUI(){
        greetingMsg?.textAlignment = .center
        inputName?.placeholder = "Enter Your name"
        primaryButton?.setTitle("Show Greeting", for: .normal)
        //uicontrol state means the current status or appearance of control: .normal, .selected, .highlighted, .disabled
    }
    func updateGreeting(_ name: String){
        greetingMsg?.text = "Hello \(name)!"
    }
    @IBAction func primaryButtonTrigger(_ sender: Any) {
        guard let name = inputName?.text, !name.isEmpty else{
            greetingMsg?.text = "please enter your name"
            return
        }
        updateGreeting(name)
        view.backgroundColor = .white
    }
}
