//
//  Comment.swift
//  Meraki
//
//  Created by Clara Jeon on 2/11/21.
//

import Foundation

public class Comment {
    var author: UserProfile
    var content: String
    var createdAt: Date
    
    init(userProfile: UserProfile, content: String, timestamp: Double){
        self.author = userProfile
        self.content = content
        self.createdAt = Date(timeIntervalSince1970: timestamp / 1000)
    }
    
    static func parseComment(_ data:[String:Any], completion: @escaping (_ comment: Comment) ->()) {
        if let uid = data["uid"] as? String {
            DatabaseManager.shared.getUserBasicProfile(uid: uid) { (userProfile) in
                if let content = data["commentContent"] as? String,
                   let timestamp = data["timestamp"] as? Double {

                    return completion(Comment(userProfile: userProfile, content: content, timestamp: timestamp))
                }
            }
        }
    }
}
