//
//  UploadPostController.swift
//  InstagramClone
//
//  Created by Seunghun Yang on 2021/04/04.
//

import UIKit

protocol UploadPostControllerDelegate: class {
    func controllerDidFinishUploadPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    // MARK: - Properties
    var currentUser: User?
    weak var delegate: UploadPostControllerDelegate?
    
    var selectedImage: UIImage? {
        didSet {
            photoImageView.image = selectedImage
        }
    }
    
    private let photoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let captionTextView: InputTextView = {
        let textView = InputTextView()
        textView.placeholderText = "Enter caption.."
        textView.font = UIFont.systemFont(ofSize: 16)
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
        captionTextView.delegate = self
         
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
    
    func checkMaxLength(_ textView: UITextView) {
        if textView.text.count > 100 {
            textView.deleteBackward()
        }
    }
    
    // MARK: - Actions
    @objc func didTapCancel() {
        print("DEBUG : Cancel tapped")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapShare() {
        guard let image = selectedImage else { return }
        guard let caption = captionTextView.text else { return }
        guard let currentUser = currentUser else { return }
        
        self.showLoader(true)
        PostService.uploadPost(caption: caption, image: image, user: currentUser) { (error) in
            self.showLoader(false)
            if let error = error {
                print("DEBUG: Failed to upload post with error \(error.localizedDescription)")
                self.dismiss(animated: true, completion: nil)
                return
            }
            self.delegate?.controllerDidFinishUploadPost(self)
        }
    }
}

// MARK: - captionTextView Delegate Methods
extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let count = textView.text.count
        checkMaxLength(textView)
        characterCountLabel.text = "\(count) / 100"
    }
}
