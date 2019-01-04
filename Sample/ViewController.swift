//
//  ViewController.swift
//  Sample
//
//  Created by Adattiri, Ramya (Cognizant) on 27/12/18.
//  Copyright © 2018 Adattiri, Ramya (Cognizant). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var entryField: UITextField!

    var loginId = ""
    var setTest: Set = [1,2,3,4,2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loginButton.isEnabled = false
        self.entryField.becomeFirstResponder()
        print(setTest);
    }
    



    @IBAction func textChanged(_ sender: UITextField) {
        
//        if let txt = sender.text {
//            loginId = txt
//            let chars = Set([Character]("0123456789"))
//            let strlength = String(txt.filter {chars.contains($0)}).count
            if checkForDigitsCount(sender.text, limit: 3) {
                self.loginButton.isEnabled = true
                self.errorLabel.text = ""
            } else{
                self.loginButton.isEnabled = false
                self.errorLabel.text = " Malformed login"

            }
//        }
    }

    func checkForDigitsCount(_ text: String?, limit: Int) -> Bool {
        guard let text = text, !text.isEmpty else { return false }
        let numbersInText = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        return numbersInText.count >= limit
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as? SecondViewController
        secondVC?.name = loginId
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .portrait
    }
}

