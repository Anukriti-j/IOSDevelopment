//
//  ViewController.swift
//  MyFirstProject
//
//  Created by Coditas on 21/07/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var greetingMsg: UILabel!
    @IBOutlet weak var primaryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = .systemBlue
        greetingMsg.textAlignment = .center
       
    }

    func greetingLabel(_ name: String){
        greetingMsg.text = "Hello \(name)"
    }
    
    
    @IBAction func primaryButtonTrigger(_ sender: Any) {
        greetingLabel("Anukriti")
        view.backgroundColor = .white
    }
    

}

