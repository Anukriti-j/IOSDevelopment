//
//  ViewController.swift
//  ProjectExplorer
//
//  Created by Coditas on 23/07/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appVersionLabel: UILabel!
    
    @IBOutlet weak var appBundleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        projectDetailsDisplay()
    }
    func projectDetailsDisplay(){
        appNameLabel.text = "App Name: Project Explorer"
        appVersionLabel.text = "Version: 1.0"
        appBundleLabel.text = "BundleId: 1"
    }
    

}

