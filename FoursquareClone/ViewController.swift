//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Ozan Çiçek on 11.11.2022.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func signInClicked(_ sender: Any) {
    }
    

    @IBAction func signUpClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" {
            let user = PFUser()
            user.username = usernameText.text
            user.password = passwordText.text
            
            user.signUpInBackground{(succes, error) in
                if error != nil {
                    makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                }else {
                    //segue
                    print("OK")
                }
            }
            
        }else {
            makeAlert(titleInput: "Error", messageInput: "Username / Password!!")
        }

        func makeAlert(titleInput: String, messageInput: String){
            let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
            
            alert.addAction(okButton)
            self.present(alert, animated: true)
        }
        
    }
    
}

