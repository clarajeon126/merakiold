//
//  Post.swift
//  Meraki
//
//  Created by Clara Jeon on 2/2/21.
//

import Foundation
import UIKit
public class Post {
    var type: String
    var title: String
    var isAnonymous: Bool
    var image: URL
    var content: String
    var author: UserProfile
    var createdAt: Date
    
    init(type: String, title: String, isAnonymous: Bool, image: URL, content: String, author: UserProfile, timestamp:Double){
        self.type = type
        self.title = title
        self.isAnonymous = isAnonymous
        self.image = image
        self.content = content
        self.author = author
        self.createdAt = Date(timeIntervalSince1970: timestamp / 1000 )
    }
    
    static func parse(_ key:String, _ data:[String:Any]) -> Post? {
        
        if let author = data["author"] as? [String:Any],
            let uid = author["uid"] as? String,
            let username = author["username"] as? String,
            let headline = author["headline"] as? String,
            let firstName = author["firstName"] as? String,
            let lastName = author["lastName"] as? String,
            let profilePhotoURL = author["profilePhotoURL"] as? String,
            let url = URL(string:profilePhotoURL),
            let type = data["type"] as? String,
            let isAnonymous = data["isAnonymous"] as? Bool,
            let mainTitle = data["title"] as? String,
            let content = data["content"] as? String,
            let postImage = author["postImage"] as? String,
            let urlPostImage = URL(string:postImage),
            let timestamp = data["timestamp"] as? Double {
            
            let userProfile = UserProfile(uid: uid, username: username, firstName: firstName, lastName: lastName, headline: headline, profilePhotoURL: url)
            
            return Post(type: type, title: mainTitle, isAnonymous: isAnonymous, image: urlPostImage, content: content, author: userProfile, timestamp: timestamp)
            
        }
        
        return nil
    }
    
    
    func getType() -> String {
        return type
    }
    
    
    
}
