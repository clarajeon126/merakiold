//
//  Opportunity.swift
//  Meraki
//
//  Created by Clara Jeon on 2/15/21.
//

import Foundation


public class Opportunity {
    
    var id: String
    var author: UserProfile
    var title: String
    var subtitle: String
    var description: String
    var dateStart: Date
    var dateEnd: Date
    var imageUrl: URL
    var category: String
    
    init(id: String, userProfile: UserProfile, title: String, subtitle:String, description: String, dateStart: Date, dateEnd: Date, imageUrl: URL, category: String) {
        self.id = id
        self.author = userProfile
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.dateStart = dateStart
        self.dateEnd = dateEnd
        self.imageUrl = imageUrl
        self.category = category
    }
    
    init(){
        self.id = " "
        self.author = UserProfile()
        self.title = " "
        self.subtitle = " "
        self.description = " "
        self.dateStart = Date()
        self.dateEnd = Date()
        self.imageUrl = URL(string: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAA1BMVEX///+nxBvIAAAASElEQVR4nO3BgQAAAADDoPlTX+AIVQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADwDcaiAAFXD1ujAAAAAElFTkSuQmCC")!
        self.category = " "
    }
    
    static func parse(data:[String:Any], completion: @escaping (_ opportunity: Opportunity)->()) {
        if let uid = data["uid"] as? String {
            DatabaseManager.shared.getUserBasicProfile(uid: uid) { (userProfile) in
                if let id = data["id"] as? String,
                   let title = data["title"] as? String,
                   let subtitle = data["subtitle"] as? String,
                   let description = data["description"] as? String,
                   let imageUrlAsString = data["imageUrl"] as? String,
                   let imageUrl = URL(string: imageUrlAsString),
                   let category = data["category"] as? String,
                   let dateStart = data["dateStart"] as? Double,
                   let dateEnd = data["dateEnd"] as? Double{
                    
                    let dateStartAsDate = Date(timeIntervalSince1970: dateStart)
                    
                    let dateEndAsDate = Date(timeIntervalSince1970: dateEnd)
                    
                    let opportunity = Opportunity(id: id, userProfile: userProfile, title: title, subtitle: subtitle, description: description, dateStart: dateStartAsDate, dateEnd: dateEndAsDate, imageUrl: imageUrl, category: category)
                    
                    return completion(opportunity)
                }
            }
        }
    }
}
