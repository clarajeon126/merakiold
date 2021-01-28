//
//  ViewController.swift
//  Meraki
//
//  Created by Clara Jeon on 1/27/21.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        handleNotAuthenticated()
        
    }
    
    private func handleNotAuthenticated() {
        if GIDSignIn.sharedInstance()?.currentUser == nil {
            let startingStoryBoard = UIStoryboard(name: "Starting", bundle: nil)
            let loginVC = startingStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false, completion: nil)
        }
    }


}

