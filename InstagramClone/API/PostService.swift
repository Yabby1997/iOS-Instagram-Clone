//
//  PostService.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/04/04.
//

import UIKit
import Firebase

struct PostService {
    
    static func uploadPost(caption: String, image: UIImage, user: User, completion: @escaping(Error?) -> Void) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) { (imageURL) in
            let postData = ["ownerUID": currentUserUID,
                        "timestamp": Timestamp(date: Date()),
                        "imageURL": imageURL,
                        "caption": caption,
                        "likes": 0,
                        "ownerUsername": user.username,
                        "ownerImageURL": user.profileImageURL] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: postData, completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map({ Post(postID: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
    
    static func fetchPosts(forUser userUID: String, completion: @escaping([Post]) -> Void) {
        let query = COLLECTION_POSTS.whereField("ownerUID", isEqualTo: userUID)
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            var posts = documents.map({ Post(postID: $0.documentID, dictionary: $0.data()) })
            
            posts.sort{ (post1, post2) -> Bool in
                return post1.timestamp.seconds > post2.timestamp.seconds
            }
            
            completion(posts)
        }
    }
}
