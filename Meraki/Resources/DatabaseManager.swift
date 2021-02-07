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
    
    //to check whether a user can be created or not
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void){
        completion(true)
    }
    
    //create a copy with a diferent user id for google sign in
    public func changeUid() {
        let uid = Auth.auth().currentUser!.uid
        database.child("users").child("googleid").observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                let email = dictionary["email"] as! String
                let username = dictionary["username"] as! String
                let firstName = dictionary["firstName"] as! String
                let lastName = dictionary["lastName"] as! String
                let profilePicString = dictionary["profilePhoto"] as! String
                let profilePicUrl = URL(string: profilePicString)
                
                DatabaseManager.shared.insertNewUser(with: email, username: username, firstName: firstName, lastName: lastName, uid: uid, userProfilePhotoUrl: profilePicUrl!) { (success) in
                    if success {
                        let ref = self.database.child("users").child("googleid").ref
                        
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
        
        UserProfile.currentUserProfile = UserProfile(uid: uid ?? "no user id", username: username, firstName: firstName, lastName: lastName, headline: " ", profilePhotoURL: userProfilePhotoUrl)
        database.child("users").child(uid).setValue(["firstName": firstName, "lastName": lastName, "email": email, "username": username, "headline": " ",
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
    
    public func queryOneUsersPost(uid: String){
        var userQuery: DatabaseQuery {
            
        }
    }

    /*public func getPostData() -> Post {
        
    }*/
    //insert posst (discussion, question, fun, other)
    
}
