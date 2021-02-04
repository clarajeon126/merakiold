//
//  DatabaseManager.swift
//  Meraki
//
//  Created by Clara Jeon on 1/28/21.
//

import Foundation
import FirebaseDatabase
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
                
                DatabaseManager.shared.insertNewUser(with: email, username: username, firstName: firstName, lastName: lastName, uid: uid) { (success) in
                    if success {
                        print("success")
                    }
                    else {
                        
                    }
                }
            }
        }
        
        let ref = database.child("users").child("googleid").ref
        
        ref.removeValue()
    }
    
    
    //inserts a new user into the database
    public func insertNewUser(with email: String, username: String, firstName: String, lastName: String, uid: String, completion: @escaping (Bool) -> Void){
        database.child("users").child(uid).setValue(["firstName": firstName, "lastName": lastName, "email": email, "username": username]) { (error, _) in
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
    
    public func addAPost(type: String, title: String, isAnonymous: Bool, content: String, user: String, completion: @escaping (Bool) -> Void){
        
    }
    
    //insert posst (discussion, question, fun, other)
    
}
