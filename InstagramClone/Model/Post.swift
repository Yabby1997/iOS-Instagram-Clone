//
//  Post.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/04/05.
//

import Firebase

struct Post {
    let postID: String
    let imageURL: String
    let timestamp: Timestamp
    let caption: String
    let ownerUID: String
    let likes: Int
    
    init(postID: String, dictionary: [String: Any]) {
        self.postID = postID
        self.imageURL = dictionary["imageURL"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.caption = dictionary["caption"] as? String ?? ""
        self.ownerUID = dictionary["ownerUID"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
    }
}
