//
//  UploadPostController.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/04/04.
//

import UIKit

class UploadPostController: UIViewController {
    // MARK: - Properties
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    
    private let captionTextView: UITextView = {
        let textView = UITextView()
        
        return textView
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Upload Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapShare))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageView.bottomAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor,
                               paddingTop: 16,
                               paddingLeft: 12,
                               paddingRight: 12,
                               height: 64)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(top: captionTextView.bottomAnchor,
                                   right: view.rightAnchor,
                                   paddingRight: 12)
    }
    
    // MARK: - Actions
    @objc func didTapCancel() {
        print("DEBUG : Cancel tapped")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapShare() {
        print("DEBUG : Share tapped")
        dismiss(animated: true, completion: nil)
    }
}
