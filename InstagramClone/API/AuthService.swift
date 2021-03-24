//
//  AuthService.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/03/24.
//

import UIKit
import Firebase

struct AuthCredential {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static func registerUser(withCredential credential: AuthCredential) {
        print(credential)
    }
}
