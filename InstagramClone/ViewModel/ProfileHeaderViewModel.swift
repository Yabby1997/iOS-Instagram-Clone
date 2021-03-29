//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/03/29.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageURL: URL? {
        return URL(string: user.profileImageURL)
    }
    
    init(user: User) {
        self.user = user
    }
}
