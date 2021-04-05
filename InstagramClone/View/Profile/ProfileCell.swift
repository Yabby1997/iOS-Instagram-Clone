//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/03/25.
//

import UIKit
import SDWebImage

class ProfileCell: UICollectionViewCell {
    // MARK: - Properties
    var viewModel: PostViewModel? {
        didSet {
            configure()
        }
    }
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
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
    
    func configure() {
        guard let viewModel = self.viewModel else { return }
        postImageView.sd_setImage(with: viewModel.imageURL, completed: nil)
    }
}
