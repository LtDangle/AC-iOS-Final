//
//  UploadView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class UploadView: UIView {
    
    var selectImageButton = UIButton()
    var commentTextView = UITextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    private func setupViews() {
        setupSelectImageButton()
        setupCommentTextView()
    }
    
    private func setupSelectImageButton() {
        selectImageButton.setImage(#imageLiteral(resourceName: "camera_icon"), for: .normal)
        selectImageButton.backgroundColor = .lightGray
        selectImageButton.layer.borderWidth = 3
        selectImageButton.layer.borderColor = UIColor.black.cgColor
        self.addSubview(selectImageButton)
        selectImageButton.translatesAutoresizingMaskIntoConstraints = false
        [selectImageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
         selectImageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
         selectImageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
         selectImageButton.heightAnchor.constraint(equalTo: selectImageButton.widthAnchor)]
        .forEach{$0.isActive = true}
    }
    private func setupCommentTextView() {
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = UIColor.black.cgColor
        commentTextView.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(commentTextView)
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        [commentTextView.topAnchor.constraint(equalTo: selectImageButton.bottomAnchor, constant: 8),
         commentTextView.leadingAnchor.constraint(equalTo: selectImageButton.leadingAnchor, constant: 8),
         commentTextView.trailingAnchor.constraint(equalTo: selectImageButton.trailingAnchor, constant: -8),
         commentTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)]
        .forEach{$0.isActive = true}
    }
    
    
}
