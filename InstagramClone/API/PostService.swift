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
}
