//
//  DatabaseManager.swift
//  Meraki
//
//  Created by Clara Jeon on 1/28/21.
//

import Foundation
import FirebaseDatabase
import Firebase
import GoogleSignIn
import FirebaseAuth

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    private let userDatabase = Database.database().reference().child("users")
    
    private let postDatabase = Database.database().reference().child("posts")
    //to check whether a user can be created or not
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void){
        completion(true)
    }
    
    //create a copy with a diferent user id for google sign in
    public func changeUid() {
        let uid = Auth.auth().currentUser!.uid
        userDatabase.child("googleid").observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                let email = dictionary["email"] as! String
                let username = dictionary["username"] as! String
                let firstName = dictionary["firstName"] as! String
                let lastName = dictionary["lastName"] as! String
                let profilePicString = dictionary["profilePhoto"] as! String
                let profilePicUrl = URL(string: profilePicString)
                
                DatabaseManager.shared.insertNewUser(with: email, username: username, firstName: firstName, lastName: lastName, uid: uid, userProfilePhotoUrl: profilePicUrl!) { (success) in
                    if success {
                        let ref = self.userDatabase.child("googleid").ref
                        
                        ref.removeValue()
                    }
                    else {
                        
                    }
                }
            }
        }

    }
    
    
    //inserts a new user into the database
    public func insertNewUser(with email: String, username: String, firstName: String, lastName: String, uid: String, userProfilePhotoUrl: URL, completion: @escaping (Bool) -> Void){
        
        UserProfile.currentUserProfile = UserProfile(uid: uid , username: username, firstName: firstName, lastName: lastName, headline: "Amazing user of Meraki!", profilePhotoURL: userProfilePhotoUrl)
        userDatabase.child(uid).setValue(["firstName": firstName, "lastName": lastName, "email": email, "username": username, "headline": "Amazing user of Meraki!",
                                                     "profilePhoto": userProfilePhotoUrl.absoluteString]) { (error, _) in
            if error == nil {
                completion(true)
                return
            }
            else {
                completion(false)
                return
            }
        }
    }
    
    public func observeUserProfile(_ uid: String, completion: @escaping ((_ userProfile: UserProfile?) -> ())) {
        let userRef = database.child("users/\(uid)")
        
        userRef.observe(.value, with: { snapshot in
            var userProfile: UserProfile?
            
            if let dict = snapshot.value as? [String: Any],
               let username = dict["username"] as? String,
               let firstName = dict["firstName"] as? String,
               let lastName = dict["lastName"] as? String,
               let headline = dict["headline"] as? String,
               let profilePhotoURL = dict["profilePhoto"] as? String,
               let url = URL(string: profilePhotoURL)
            {
                
                userProfile = UserProfile(uid: uid, username: username, firstName: firstName, lastName: lastName, headline: headline, profilePhotoURL: url)
            }
            
            completion(userProfile)
        })
    }

        public var onlyUserPostsQuery: DatabaseQuery {
            var onlyUserQueryRef:DatabaseQuery
            
            onlyUserQueryRef = postDatabase.queryOrdered(byChild: "uid").queryEqual(toValue: UserProfile.currentUserProfile?.uid)
            return onlyUserQueryRef
        }
    
    public func getUserPost(completion:@escaping (_ posts:[Post])->()){
        
        onlyUserPostsQuery.observeSingleEvent(of: .value) { (snapshot) in
            var userPosts = [Post]()
            var numOfChildThroughFor = 0
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let data = childSnapshot.value as? [String:Any]{
                    Post.parse(key: childSnapshot.key, data: data) { (post) in
                        userPosts.insert(post, at: 0)
                        numOfChildThroughFor += 1
                        print(userPosts)
                        if numOfChildThroughFor == snapshot.childrenCount {
                            print(userPosts)
                            return completion(userPosts)
                        }
                    }
                    
                }
            }
        }
    }
    
    public func insertComments(postId: String, content: String){
        let userUid = UserProfile.currentUserProfile?.uid
        
        let commentsRef = postDatabase.child(postId).child("comments").childByAutoId()
        
        let commentObj = ["uid": userUid,
                          "commentContent": content,
                          "timestamp": [".sv":"timestamp"]
        ] as [String : Any]
        
        commentsRef.setValue(commentObj)
    }
    
        
    public func createCommentArrayForPost(postId: String, completion: @escaping (_ comments: [Comment])->()) {
        
        var queryCommentByTime:DatabaseQuery {
            var commentByPostQueryRef: DatabaseQuery
            
            var commentRef = database.child("posts/\(postId)/comments")
            commentByPostQueryRef = commentRef.queryOrdered(byChild: "timestamp")
            
            return commentByPostQueryRef
        }

        queryCommentByTime.observeSingleEvent(of: .value) { (snapshot) in
            var postComments = [Comment]()
            var numOfChildThroughFor = 0
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    if let data = childSnapshot.value as? [String:Any]{
                        Comment.parseComment(data) { (comment) in
                            numOfChildThroughFor += 1
                            postComments.insert(comment, at: 0)
                            
                            if numOfChildThroughFor == snapshot.childrenCount {
                                return completion(postComments)
                            }
                        }
                    }
                }
            }
        }
    }
    
    public func getNumberOfCommentsOnPost(postId: String, completion: @escaping (_ commentCount: Int)->()) {
        postDatabase.child(postId).child("comments").observe(DataEventType.value) { (snapshot) in
             let commentCount = snapshot.childrenCount
            return completion(Int(commentCount))
        }
    }

    
    public func changeFirstLastNameUser(newFirst:String, newLast:String){
        guard let currentUserUid = UserProfile.currentUserProfile?.uid else {
            return
        }
        
        userDatabase.child(currentUserUid).updateChildValues(["firstName": newFirst, "lastName": newLast])
        
    }
    
    public func changeHeadlineUser(newHeadline: String){
        guard let currentUserUid = UserProfile.currentUserProfile?.uid else {
            return
        }
        
        userDatabase.child(currentUserUid).updateChildValues( ["headline": newHeadline])
    }
    
    public func changeProfilePhotoUser(newProfilePhotoUrl: String){
        guard let currentUserUid = UserProfile.currentUserProfile?.uid else {
            return
        }
        
        userDatabase.child(currentUserUid).updateChildValues( ["profilePhoto": newProfilePhotoUrl])
    }
    
    public func getUserBasicProfile(uid: String, completion: @escaping (_ userProfile: UserProfile)->()){
        userDatabase.child(uid).observe(.value) { (snapshot) in
            if let data = snapshot.value as? [String: Any],
               let username = data["username"] as? String,
               let firstName = data["firstName"] as? String,
               let lastName = data["lastName"] as? String,
               let headline = data["headline"] as? String,
               let profilePhotoUrlAsString = data["profilePhoto"] as? String,
               let profilePhotoUrl = URL(string: profilePhotoUrlAsString) {
                
                //create user profile to return
                let userProfile = UserProfile(uid: uid, username: username, firstName: firstName, lastName: lastName, headline: headline, profilePhotoURL: profilePhotoUrl)
                
                return completion(userProfile)
            }
        }
    }
    
    public func addAboutUser(aboutUser: AboutUser) {
        guard let userUid = UserProfile.currentUserProfile?.uid else {
            return
        }
        
        let aboutYouObj = ["whoAreYou": aboutUser.whoAreYou, "merakiProject": aboutUser.merakiProject, "skills": aboutUser.skills, "accomplishments": aboutUser.accomplishments, "passion": aboutUser.passion] as [String: Any]
        
        userDatabase.child(userUid).child("aboutYou").setValue(aboutYouObj)
    }
    
    public func getAboutUser(uid: String, completion: @escaping (_ aboutUser: AboutUser)->()){
        userDatabase.child(uid).child("aboutYou").observe(.value) { (snapshot) in
            if let data = snapshot.value as? [String: Any],
               let whoAreYou = data["whoAreYou"] as? String,
               let merakiProject = data["merakiProject"] as? String,
               let skills = data["skills"] as? String,
               let accomplishments = data["accomplishments"] as? String,
               let passion = data["passion"] as? String {
                let aboutUser = AboutUser(whoAreYou: whoAreYou, merakiProject: merakiProject, skills: skills, accomplishments: accomplishments, passion: passion)
                return completion(aboutUser)
            }
        }
    }
    //public func getAboutUserInfo(

    /*public func getPostData() -> Post {
        
    }*/
    //insert posst (discussion, question, fun, other)
    
}
