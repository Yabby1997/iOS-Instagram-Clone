//
//  User.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/03/29.
//

import Foundation

struct User {
    let email: String
    let fullname: String
    let profileImageURL: String
    let username: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as?  String ?? ""
        self.fullname = dictionary["fullname"] as?  String ?? ""
        self.profileImageURL = dictionary["profileImageURL"] as?  String ?? ""
        self.username = dictionary["username"] as?  String ?? ""
        self.uid = dictionary["uid"] as?  String ?? ""
    }
}
