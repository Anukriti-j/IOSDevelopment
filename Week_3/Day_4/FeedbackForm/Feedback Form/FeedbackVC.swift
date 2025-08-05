import UIKit

class FeedbackVC: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var experienceSlider: UISlider!
    @IBOutlet weak var experienceText: UITextField!
    @IBOutlet weak var recommendSwitch: UISwitch!
    @IBOutlet weak var recommendText: UITextField!
    @IBOutlet weak var visitCountText: UITextField!
    @IBOutlet weak var countStepper: UIStepper!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var parentStackview: UIStackView!
    @IBOutlet weak var formView: UIView!
    
    var selectedGender = -1
    var experienceSet = false
    var countSet = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feedback Form"
        setInitialState()
        nameText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        mailText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        setInitialState()
    }
    
    @IBAction func controlChanged(_ sender: UIControl) {
        if let slider = sender as? UISlider {
            experienceText.text = String(Int(slider.value))
            experienceSet = true
        } else if let recommendUISwitch = sender as? UISwitch {
            recommendText.text = recommendUISwitch.isOn ? "Yes" : "No"
        } else if let stepper = sender as? UIStepper {
            visitCountText.text = String(Int(stepper.value))
            countSet = true
        } else if let segmentControl = sender as? UISegmentedControl {
            selectedGender = segmentControl.selectedSegmentIndex
        }
        updateProgress()
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard formIsValid() else { return }
        sender.isEnabled = false
        resetButton.isEnabled = false
        parentStackview.isUserInteractionEnabled = false
        formView.isHidden = true
        activityIndicatorView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.activityIndicatorView.stopAnimating()
            sender.isEnabled = true
            self.resetButton.isEnabled = true
            self.showAlert(title: "Success", message: "Thank you for your feedback!")
            self.setInitialState()
            self.formView.isHidden = false
            self.parentStackview.isUserInteractionEnabled = true
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateProgress()
    }
    
    private func setInitialState() {
        nameText.text = ""
        mailText.text = ""
        experienceSlider.value = 0
        experienceText.text = ""
        experienceSet = false
        recommendSwitch.isOn = false
        recommendText.text = ""
        countStepper.value = 0
        visitCountText.text = "0"
        countSet = false
        genderSegmentedControl.selectedSegmentIndex = UISegmentedControl.noSegment
        selectedGender = -1
        
        let normalAttributes: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.white ]
        genderSegmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        
        progressView.setProgress(0.0, animated: false)
        updateProgress()
    }
    
    private func updateProgress() {
        var progress: Float = 0.0
        let name = nameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let mail = mailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if !name.isEmpty { progress += 0.2 }
        if !mail.isEmpty { progress += 0.2 }
        if experienceSet { progress += 0.2 }
        if !recommendText.text!.isEmpty { progress += 0.2 }
        if countSet { progress += 0.1 }
        if genderSegmentedControl.selectedSegmentIndex != UISegmentedControl.noSegment { progress += 0.1 }
        progressView.setProgress(progress, animated: true)
    }
    
    private func formIsValid() -> Bool {
        let name = nameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let mail = mailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let experienceGiven = experienceText.text != ""
        let recommendGiven = !recommendText.text!.isEmpty
        let visits = Int(countStepper.value)
        let genderChosen = genderSegmentedControl.selectedSegmentIndex != UISegmentedControl.noSegment
        
        guard !name.isEmpty else {
            showAlert(title: "Missing Name", message: "Please enter your name.")
            return false
        }
        guard !mail.isEmpty else {
            showAlert(title: "Missing Email", message: "Please enter your email.")
            return false
        }
        guard mailIsValid() else {
            showAlert(title: "Invalid Email", message: "Please enter valid email.")
            return false
        }
        guard experienceGiven && recommendGiven && visits > 0 && genderChosen else {
            showAlert(title: "Incomplete", message: "Please complete all fields before submitting.")
            return false
        }
        return true
    }
    
    private func mailIsValid() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: mailText.text)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
