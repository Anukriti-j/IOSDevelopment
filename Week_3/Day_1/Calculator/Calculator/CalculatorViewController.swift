import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    var currentInput: String = ""
    var lastResult: String = ""
    var openBracesCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let alwaysAllowedTags: [Int] = [10, 17, 18]
        if alwaysAllowedTags.contains(sender.tag) {
            handleSpecialButtons(sender.tag)
            return
        }
        if currentInput.count >= 30 {
            showAlert(title: "Input limit reached", message: "You can't enter more than 30 characters")
            return
        }
        
        switch sender.tag {
        case 0...9:
            currentInput += "\(sender.tag)"
            displayLabel.text = currentInput
        case 11: // (
            if currentInput.isEmpty || "+-*/(".contains(currentInput.last!) {
                currentInput += "("
                openBracesCount += 1
            }
        case 12: // )
            if openBracesCount > 0 && "0123456789".contains(currentInput.last!) {
                currentInput += ")"
                openBracesCount -= 1
            }
        case 13:
            placeOperators("/")
        case 14:
            placeOperators("*")
        case 15:
            placeOperators("-")
        case 16:
            placeOperators("+")
            
        case 20: // decimal
            currentInput += "."
            
        default:
            break
        }
        
        if !currentInput.isEmpty && sender.tag != 17 { // 17 is "="
            displayLabel.text = currentInput
        }
    }
    
    private func handleSpecialButtons(_ tag: Int) {
        switch tag{
        case 10: // AC
            currentInput = ""
            displayLabel.text = "0"
        case 17:
            calculateResult()
            
        case 18: // Clear last input
            if !currentInput.isEmpty {
                currentInput.removeLast()
                displayLabel.text = currentInput
            }
        default:
            break
        }
    }
    
    private func placeOperators(_ operation: String) {
        outerCondition: if currentInput.isEmpty, !lastResult.isEmpty {
            currentInput = lastResult + operation
        } else {
            let last = currentInput.last!
            if "+-*/".contains(last) {
                currentInput.removeLast()
            } else if "(".contains(last) {
                break outerCondition
            }
            currentInput += operation }
    }
    
    private func calculateResult() {
        let pattern = #"(?<!\d|\.)\b(\d+)\b(?!\.\d|\d*\.\d)"# // Converting int only digits to decimal
        let adjustedInput = currentInput.replacingOccurrences(of: pattern, with: "$1.0", options: .regularExpression)
        let exp = NSExpression(format: adjustedInput)
        if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
            let doubleValue = result.doubleValue
            if doubleValue.isInfinite {
                lastResult = "Indefinite"
                displayLabel.text = "Indefinite"
            } else if doubleValue.isNaN {
                lastResult = "Invalid Expression"
                displayLabel.text = "Invalid Expression"
            } else {
                lastResult = "\(doubleValue)"
                displayLabel.text = "\(doubleValue)"
            }
            currentInput = ""
        } else {
            lastResult = "Invalid Expression"
            displayLabel.text = "Invalid Expression"
            currentInput = ""
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

