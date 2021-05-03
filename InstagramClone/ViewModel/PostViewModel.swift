//
//  PostViewModel.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/04/05.
//

import Foundation

struct PostViewModel {
    let post: Post
    
    var imageURL: URL? {
        return URL(string: post.imageURL)
    }
    
    var caption: String {
        return post.caption
    }
    
    var likesLabelText: String {
        if post.likes != 0 {
            return "\(post.likes) likes"
        } else {
            return "\(post.likes) like"
        }
    }
    
    var profileImageURL: URL? {
        return URL(string: post.ownerImageURL)
    }
    
    var username: String {
        return post.ownerUsername
    }
    
    init(post: Post) {
        self.post = post
    }

}
