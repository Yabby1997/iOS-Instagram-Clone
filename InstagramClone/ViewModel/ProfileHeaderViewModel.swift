//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/03/29.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    var profileImageURL: URL? {
        return URL(string: user.profileImageURL)
    }
    
    init(user: User) {
        self.user = user
    }
}
