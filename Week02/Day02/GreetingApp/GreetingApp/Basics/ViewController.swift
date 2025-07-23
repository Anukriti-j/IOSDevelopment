//
//  ViewController.swift
//  MyFirstProject
//
//  Created by Coditas on 21/07/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var greetingMsg: UILabel?
    @IBOutlet weak var primaryButton: UIButton?
    
    @IBOutlet weak var inputName: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
       
    }
    private func setupUI(){
        greetingMsg?.textAlignment = .center
        inputName?.placeholder = "Enter Your name"
        primaryButton?.setTitle("Show Greeting", for: .normal)
        //uicontrol state means the current status or appearance of control: .normal, .selected, .highlighted, .disabled
    }

    func greetingLabel(_ name: String){
        greetingMsg?.text = "Hello \(name)!"
    }
    
    
    @IBAction func primaryButtonTrigger(_ sender: Any) {
        if let name = inputName?.text, !name.isEmpty{
            greetingLabel(name)
            view.backgroundColor = .white
        }else{
            greetingMsg?.text = "please enter your name"
        }
        
    }
    
    

}

