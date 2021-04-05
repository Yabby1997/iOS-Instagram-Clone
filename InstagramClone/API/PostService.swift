//
//  PostService.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/04/04.
//

import UIKit
import Firebase

struct PostService {
    
    static func uploadPost(caption: String, image: UIImage, completion: @escaping(Error?) -> Void) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) { (imageURL) in
            let postData = ["ownerUID": currentUserUID,
                        "timestamp": Timestamp(date: Date()),
                        "imageURL": imageURL,
                        "caption": caption,
                        "likes": 0] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: postData, completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map({ Post(postID: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
}
