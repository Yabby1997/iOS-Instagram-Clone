//
//  ProfileHeader.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/03/25.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}
