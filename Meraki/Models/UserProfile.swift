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
    init(){
        self.uid = " "
        self.username = " "
        self.firstName = " "
        self.lastName = " "
        self.headline = " "
        
        self.profilePhotoURL = URL(string: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAA1BMVEX///+nxBvIAAAASElEQVR4nO3BgQAAAADDoPlTX+AIVQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADwDcaiAAFXD1ujAAAAAElFTkSuQmCC")!
    }
    
    
    static func parse(data:[String: Any], completion: @escaping (_ user: UserProfile)->()) {
        if let uid = data["uid"] as? String,
           let username = data["username"] as? String,
           let firstName = data["firstName"] as? String,
           let lastName = data["lastName"] as? String,
           let headline = data["headline"] as? String,
           let profilePhotoUrlAsString = data["profilePhoto"] as? String,
           let profilePhotoUrl = URL(string: profilePhotoUrlAsString) {
            print(firstName)
            let userProfile = UserProfile(uid: uid, username: username, firstName: firstName, lastName: lastName, headline: headline, profilePhotoURL: profilePhotoUrl)
            return completion(userProfile)
        }
    }
}
