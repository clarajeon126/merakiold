//
//  AboutUser.swift
//  Meraki
//
//  Created by Clara Jeon on 2/14/21.
//

import Foundation

public class AboutUser {
    var whoAreYou: String
    var merakiProject: String
    var skills: String
    var accomplishments: String
    var passion: String
    
    init(whoAreYou: String, merakiProject: String, skills: String, accomplishments: String, passion: String) {
        self.whoAreYou = whoAreYou
        self.merakiProject = merakiProject
        self.skills = skills
        self.accomplishments = accomplishments
        self.passion = passion
    }
}
