//
//  PostCell.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    var indexPath: Int!
    var postImageView = UIImageView()
    var postComment = UILabel()
    
    var imageCache = [Int: UIImage]()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
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
        setupPostImageView()
        setupPostComment()
    }
    private func setupPostImageView() {
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        
        contentView.addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        [postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
         postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor)]
        .forEach{$0.isActive = true}
    }
    private func setupPostComment() {
        postComment.numberOfLines = 0
        postComment.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(postComment)
        postComment.translatesAutoresizingMaskIntoConstraints = false
        [postComment.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 8),
         postComment.leadingAnchor.constraint(equalTo: postImageView.leadingAnchor, constant: 8),
         postComment.trailingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: -8),
         postComment.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)]
        .forEach{$0.isActive = true}
    }
    
    
    public func configure(withPost post: Post, forIndexPath indexPath: IndexPath) {
        guard self.indexPath == indexPath.row else {
            return
        }
        
        self.postComment.text = post.comment
//        if let image = imageCache[indexPath.row] {
//            self.postImageView.image = image
//            self.setNeedsLayout()
//        } else {
//            DatabaseService.manager.getImage(fromKey: post.id) { (image, error) in
//                if let error = error {
//                    print(error)
//                } else {
//
//                    DispatchQueue.main.async { [weak self] in
////                        guard self?.indexPath == indexPath.row else {
////                            self?.postImageView.image = nil
////                            self?.setNeedsLayout()
////                            return
////                        }
//                        print("gotImage")
//                        self?.postImageView.image = image
//                        self?.imageCache[indexPath.row] = image
//                        self?.setNeedsLayout()
//                    }
//                }
//            }
//        }
    }
}
