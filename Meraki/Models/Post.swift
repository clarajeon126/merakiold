//
//  Post.swift
//  Meraki
//
//  Created by Clara Jeon on 2/2/21.
//

import Foundation
import UIKit
public class Post {
    var id: String
    var type: String
    var title: String
    var isAnonymous: Bool
    var image: URL
    var content: String
    var author: UserProfile
    var createdAt: Date
    
    init(id: String, type: String, title: String, isAnonymous: Bool, image: URL, content: String, author: UserProfile, timestamp:Double){
        self.id = id
        self.type = type
        self.title = title
        self.isAnonymous = isAnonymous
        self.image = image
        self.content = content
        self.author = author
        self.createdAt = Date(timeIntervalSince1970: timestamp / 1000 )
    }
    
    init(){
        self.id = " "
        self.type = " "
        self.title = " "
        self.isAnonymous = false
        self.image = UserProfile.currentUserProfile!.profilePhotoURL
        self.content = " "
        self.author = UserProfile()
        self.createdAt = Date()
    }
    
    static func parse(key:String, data:[String:Any], completion: @escaping (_ post: Post)->()) {
        
        print("parsing post")
        if let uid = data["uid"] as? String {
            print(uid)
            DatabaseManager.shared.getUserBasicProfile(uid: uid) { (userProfile) in
                print(userProfile)
                if let type = data["type"] as? String,
                   let isAnonymous = data["isAnonymous"] as? Bool,
                   let mainTitle = data["mainTitle"] as? String,
                   let content = data["content"] as? String,
                   let postImage = data["imageurl"] as? String,
                   let urlPostImage = URL(string:postImage),
                   let timestamp = data["timestamp"] as? Double {
                    print("insideif")
                    let post = Post(id: key, type: type, title: mainTitle, isAnonymous: isAnonymous, image: urlPostImage, content: content, author: userProfile, timestamp: timestamp)
                    print("post title: \(post.title)")
                    return completion(Post(id: key, type: type, title: mainTitle, isAnonymous: isAnonymous, image: urlPostImage, content: content, author: userProfile, timestamp: timestamp))
                }
            }
        }
    }
    
    
    func getType() -> String {
        return type
    }
    
    
    
}
