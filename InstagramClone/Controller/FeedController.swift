//
//  FeedController.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/03/17.
//

import UIKit
import Firebase

class FeedController: UICollectionViewController {
    // MARK: - Properties
    
    private var posts = [Post]()
    let reuseIdentifier = "Cell"
    
    // MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchPosts()
    }
    
    // MARK: - API
    func fetchPosts() {
        PostService.fetchPosts { (posts) in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Helpers
    func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    // MARK: - Actions
    @objc func handleRefresh() {
        PostService.fetchPosts { (posts) in
            self.posts.removeAll()
            self.posts = posts
            self.collectionView.reloadData()
        }
        self.collectionView.refreshControl?.endRefreshing()
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG: Failed to sign out. \(error.localizedDescription)")
        }
    }
}

// MARK: - UICollectionViewDataSource Methods
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        
        return cell
    }
}

// MARK: - Extensions
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8  + 40  + 8
        height += 110
        
        return CGSize(width: width, height: height)
    }
}
