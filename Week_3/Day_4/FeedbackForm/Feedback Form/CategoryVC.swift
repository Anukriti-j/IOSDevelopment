import UIKit

class CategoryVC: UIViewController {
    
    @IBOutlet weak var CategoryPickerView: UIPickerView!
    
    let categories = ["Support", "Product", "Feedback", "Service", "Others"]
    var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CategoryPickerView.delegate = self
        CategoryPickerView.dataSource = self
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard selectedRow != nil else {
            showAlert(message: "No row selected")
            return
        }
        if selectedRow == 2 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let secondVC = storyboard.instantiateViewController(withIdentifier: "FeedbackVC") as? FeedbackVC {
                self.navigationController?.pushViewController(secondVC, animated: true)
            }
        }
        else {
            showAlert(message: "No navigation for this field")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension CategoryVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow =  row
    }
}
