//
//  ProfileViewController.swift
//  Meraki
//
//  Created by Clara Jeon on 1/27/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var myPosts = [Post]()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var myPostTableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHeadlineLabel: UILabel!
    @IBOutlet weak var postsView: UIView!
    @IBOutlet weak var aboutView: UIView!
    @IBAction func segmentControllerChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            aboutView.isHidden = false
            postsView.isHidden = true
        }
        else {
            postsView.isHidden = false
            aboutView.isHidden = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.width /  2
        let userFirstName = UserProfile.currentUserProfile?.firstName ?? "Jane"
        let userLastName = UserProfile.currentUserProfile?.lastName ?? "Doe"
        let userHeadline = UserProfile.currentUserProfile?.headline ?? "Your Headline..."
        
        profileImage.image = nil
        ImageService.getImage(withURL: UserProfile.currentUserProfile!.profilePhotoURL) { (userProfileImage, url) in
            self.profileImage.image = userProfileImage
        }
        userName.text = userFirstName + " " + userLastName
        userHeadlineLabel.text = userHeadline
    }
    
    

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        return cell
    }
}
