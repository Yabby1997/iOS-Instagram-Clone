//
//  Constants.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/03/28.
//

import Firebase

// MARK: - Firestore Collections
let COLLECTION_USERS = Firestore.firestore().collection("users")

let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")

let COLLECTION_POSTS = Firestore.firestore().collection("posts")
