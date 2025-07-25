import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var appBundleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        appDetailsDisplay()
    }
    func appDetailsDisplay(){
        let bundle = Bundle.main
        guard let infoDict = bundle.infoDictionary else{
            appNameLabel.text = "App Name: Error"
            appVersionLabel.text = "Version: Error"
            appBundleLabel.text = "Bundle ID: Error"
            return
        }
        let appName = (infoDict["CFBundleDisplayName"] as? String) ?? (infoDict["CFBundleName"] as? String) ?? "N/A"
        let appVersion = (infoDict["CFBundleShortVersionString"] as? String) ?? "N/A"
        let appBundleID = bundle.bundleIdentifier ?? "N/A"
        appNameLabel.text = "App Name: \(appName)"
        appVersionLabel.text = "Version: \(appVersion)"
        appBundleLabel.text = "BundleID: \(appBundleID)"
    }
}
