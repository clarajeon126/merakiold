//
//  UserProfile.swift
//  Meraki
//
//  Created by Clara Jeon on 2/4/21.
//

import Foundation

public class UserProfile {
    
    static var currentUserProfile:UserProfile?
    
    var uid:String
    var username:String
    var firstName: String
    var lastName: String
    var headline: String
    var profilePhotoURL:URL
    
    
    init(uid:String, username:String, firstName:String, lastName:String, headline: String, profilePhotoURL: URL) {
        self.uid = uid
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.headline = headline
        self.profilePhotoURL = profilePhotoURL
    }
    
    
    func setFirstName(newFirstName: String){
        
    }
    
    func setLastName(newLastName: String){
        
    }
    
    func setHeadline(newHeadline: String) {
        
    }
    
    func setProfilePhoto(newPhotoURL: URL) {
        
    }
}
