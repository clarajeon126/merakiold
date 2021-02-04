//
//  SettingsViewController.swift
//  Meraki
//
//  Created by Clara Jeon on 2/1/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func signOutTapped(_ sender: Any) {
        AuthManager.shared.logOut(completion: {success in
            DispatchQueue.main.async {
                if success {
                    let startingStoryBoard = UIStoryboard(name: "Starting", bundle: nil)
                    let loginVC = startingStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true) {
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabBarController?.selectedIndex = 2
                    }
                }
            }
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
