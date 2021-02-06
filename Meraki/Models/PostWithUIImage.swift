//
//  PostWithUIImage.swift
//  Meraki
//
//  Created by Clara Jeon on 2/6/21.
//

import Foundation
import UIKit

public class PostWithUIImage {
    var type: String
    var title: String
    var isAnonymous: Bool
    var image: UIImage
    var content: String
    var author: UserProfile
    
    init(typeOfPost: String, titleOfPost: String, isAnonymous: Bool, imageUI: UIImage, contentOfPost: String, author: UserProfile){
        self.type = typeOfPost
        self.title = titleOfPost
        self.isAnonymous = isAnonymous
        self.image = imageUI
        self.content = contentOfPost
        self.author = author
    }
}
