//
//  UserService.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/03/28.
//

import Firebase

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.map({ User(dictionary: $0.data())})
            completion(users)
        }
    }
    
    static func follow(uid: String, completion: @escaping (Error?) -> Void) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUserUID).collection("following").document(uid).setData([:]) { (error) in
            COLLECTION_FOLLOWERS.document(uid).collection("followers").document(currentUserUID).setData([:], completion: completion)
        }
    }
    
    static func unfollow(uid: String, completion: @escaping (Error?) -> Void) {
        
    }
}
