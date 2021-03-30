//
//  UserCellViewModel.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/03/30.
//

import Foundation

struct UserCellViewModel {
    // MARK: - Properties
    private let user: User
    
    var profileImageURL: URL? {
        return URL(string: user.profileImageURL)
    }
    
    var username: String {
        return user.username
    }
    
    var fullname: String {
        return user.fullname
    }
     
    init(user: User) {
        self.user = user
    }
}
