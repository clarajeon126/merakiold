//
//  PostDepthViewController.swift
//  Meraki
//
//  Created by Clara Jeon on 2/1/21.
//

import UIKit

class PostDepthViewController: UIViewController {

    @IBOutlet weak var profilePhotoImageView: UIImageView!
    var profilePhoto = UIImage()
    
    @IBOutlet weak var titleLabel: UILabel!
    var postTitle = String()
    
    @IBOutlet weak var userFirstLastNameLabel: UILabel!
    var firstLastName = String()
    
    @IBOutlet weak var headlineLabel: UILabel!
    var headline = String()
    
    @IBOutlet weak var contentLabel: UILabel!
    var content = String()
    
    @IBOutlet weak var overallImageView: UIImageView!
    var postImage = UIImage()
    
    @IBOutlet weak var commentsTableView: UITableView!

    var postId = String()
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsTableView.register(UINib.init(nibName: "SelfCommentTableViewCell", bundle: nil), forCellReuseIdentifier: "selfCommentCell")
        commentsTableView.register(UINib.init(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "commentCellId")
        
        self.profilePhotoImageView.image = nil
        self.profilePhotoImageView.image = self.profilePhoto
        self.profilePhotoImageView.layer.cornerRadius = self.profilePhotoImageView.frame.width / 2
        self.titleLabel.text = self.postTitle
        self.userFirstLastNameLabel.text = self.firstLastName
        self.headlineLabel.text = self.headline
        self.contentLabel.text = self.content
        self.overallImageView.image = nil
        self.overallImageView.image = self.postImage
    
        //setting up comments table view
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        commentsTableView.reloadData()
        
        updateCommentArrayAndTableView()
    }
    public func updateCommentArrayAndTableView(){
        DatabaseManager.shared.createCommentArrayForPost(postId: postId) { (commentArray) in
            self.comments.removeAll()
            self.comments.insert(contentsOf: commentArray, at: 0)
            print(self.comments)
            self.commentsTableView.reloadData()
            print("inserted to major array")
        }
    }
}

extension PostDepthViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = commentsTableView.dequeueReusableCell(withIdentifier: "selfCommentCell") as! SelfCommentTableViewCell
            cell.postId = postId
            cell.postButton.addTarget(self, action: #selector(postTapped(_:)), for: .touchUpInside)
            return cell
        }
        else {
            let cell = commentsTableView.dequeueReusableCell(withIdentifier: "commentCellId") as! CommentTableViewCell
            cell.set(comment: comments[indexPath.row])
            return cell
        }
    }
    @objc func postTapped(_ sender: UIButton){
        updateCommentArrayAndTableView()
    }
}

