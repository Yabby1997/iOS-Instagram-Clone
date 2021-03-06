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
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUserUID).collection("following").document(uid).delete { (error) in
            COLLECTION_FOLLOWERS.document(uid).collection("followers").document(currentUserUID).delete(completion: completion)
        }
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void) {
        guard let currentUserUID = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUserUID).collection("following").document(uid).getDocument { (snapshot, error) in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
    
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        COLLECTION_FOLLOWERS.document(uid).collection("followers").getDocuments { (snapshot, error) in
            let followers = snapshot?.documents.count ?? 0
            COLLECTION_FOLLOWING.document(uid).collection("following").getDocuments { (snapshot, error) in
                let following = snapshot?.documents.count ?? 0
                COLLECTION_POSTS.whereField("ownerUID", isEqualTo: uid).getDocuments { (snapshot, error) in
                    let posts = snapshot?.documents.count ?? 0
                    
                    completion(UserStats(followers: followers, following: following, posts: posts))
                }
            }
        }
    }
}
