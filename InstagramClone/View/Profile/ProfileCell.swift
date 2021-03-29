//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/03/25.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    // MARK: - Properties
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "venom-7")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureViewController() {
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
}
