//
//  RegisterViewController.swift
//  Meraki
//
//  Created by Clara Jeon on 1/27/21.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text,!email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8,
              let username = usernameField.text, !username.isEmpty else {
            return
        }
        
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { (registered) in
            DispatchQueue.main.async {
                if registered {
                    
                }
                else {
                    
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.isSecureTextEntry = true
            
        usernameField.returnKeyType = .next
        emailField.returnKeyType = .next
        passwordField.returnKeyType = .continue
        
        usernameField.autocorrectionType = .no
        emailField.autocorrectionType = .no
        passwordField.autocorrectionType = .no
        
        usernameField.autocapitalizationType = .none
        emailField.autocapitalizationType = .none
        passwordField.autocapitalizationType = .none
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            createAccountButtonTapped(self)
        }
        
        return true
    }
}
