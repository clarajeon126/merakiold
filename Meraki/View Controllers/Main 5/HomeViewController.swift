//
//  ViewController.swift
//  Meraki
//
//  Created by Clara Jeon on 1/27/21.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let postTableCellId = "postCell"
    var posts = [postTableCell]()
    
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        postTableView.register(UINib.init(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: postTableCellId)
        postTableView.dataSource = self
        postTableView.delegate = self
        /*
        for x in 0...2{
            //takes random item from array and loads up different things onto cell when the page loads
            // make segue to description vc
            let post = postTableCell()
            post?.mainTitle = postsArray[x].titleOfposts
            post?.emoji = postsArray[x].emojiOfposts
            post?.points = postsArray[x].pointValue
            posts.append(post!)
        
        }*/
        postTableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        handleNotAuthenticated()
        
    }
    func tableView(_ tatbleView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tableViewHeight = postTableView.frame.height
        return tableViewHeight/3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: postTableCellId, for: indexPath) as! PostTableViewCell
        
        /*
        cell.selectionStyle = .none
        
        let post = posts[indexPath.row]
        
        cell.userNameLabel.text =
        
        cell.emojiLabel.text = post.emoji
        */
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "goToDescription", sender: self)
    }*/
    
    //handleing not authenticated
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let startingStoryBoard = UIStoryboard(name: "Starting", bundle: nil)
            let loginVC = startingStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false, completion: nil)
        }
        else{
            DatabaseManager.shared.observeUserProfile(Auth.auth().currentUser!.uid) { (userProfile) in
                UserProfile.currentUserProfile = userProfile
            }
        }
    }


}

