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
    var image: UIImage
    var content: String
    var userID: String
    
    init(type: String, title: String, isAnonymous: Bool, image: UIImage, content: String){
        self.type = type
        self.title = title
        self.isAnonymous = isAnonymous
        self.image = image
        self.content = content
        self.userID = AuthManager.shared.getUserId()
    }
    
    func addPostToDatabase(){
        DatabaseManager.shared.addAPost(type: type, title: title, isAnonymous: isAnonymous, content: content, user: userID) { (success) in
            if success {
                
            }
            else {
                
            }
        }
    }
    
    
    
    
}
