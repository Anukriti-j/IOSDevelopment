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
        switch sender.tag {
        case 0...9:
            currentInput += "\(sender.tag)"
            displayLabel.text = currentInput
            
        case 10: // AC
            currentInput = ""
            displayLabel.text = "0"
            
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
        case 17:
            calculateResult()
            
        case 18: // Clear last input
            if !currentInput.isEmpty {
                currentInput.removeLast()
                displayLabel.text = currentInput
            }
            
        case 20: // decimal
            currentInput += "."
            
        default:
            break
        }
        
        if !currentInput.isEmpty && sender.tag != 17 { // 17 is "="
            displayLabel.text = currentInput
        }
    }
    
    private func calculateResult() {
        let exp = NSExpression(format: currentInput)
        if let result = exp.expressionValue(with: nil, context: nil) as? NSNumber {
            lastResult = "\(result)"
            displayLabel.text = "\(result)"
            currentInput = ""
        } else {
            displayLabel.text = "Error"
            currentInput = ""
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
}

