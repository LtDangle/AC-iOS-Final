//
//  PostFeedViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class PostFeedViewController: UIViewController {
    
    var tableView = UITableView()
    var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        self.navigationItem.title = "Feed"
        
        
        loadData()
        
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        [tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
         tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
         tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)]
        .forEach{$0.isActive = true}
    }
    
    private func loadData() {
        DatabaseService.manager.getPosts { [unowned self] (posts, error) in
            if let error = error {
                print(error)
                return
            } else {
                self.posts = posts!
            }
        }
    }
    
    
}

extension PostFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        
        cell.indexPath = indexPath.row
        cell.configure(withPost: post, forIndexPath: indexPath)
        DispatchQueue.global().async {
            DatabaseService.manager.getImage(fromKey: post.id, completion: { (image, error) in
                if let error = error {
                    print(error)
                } else {
                    DispatchQueue.main.async {
                        guard tableView.indexPath(for: cell) == indexPath else {
                            return
                        }
                        cell.postImageView.image = image
                    }
                }
            })
            
        }
        
        
        
        return cell
    }
    
    
}

extension PostFeedViewController: UITableViewDelegate {
    
}

