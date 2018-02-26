//
//  MainTabBarController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // TODO: Add Pages:
    // - Login
    let loginVC = LoginPageViewController()
    // - Main Feed
    let feedVC = PostFeedViewController()
    // - Upload
    let uploadVC = UploadPostViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserService.manager.userListener = self
        
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: #imageLiteral(resourceName: "chickenleg"), tag: 0)
        uploadVC.tabBarItem = UITabBarItem(title: "Upload", image: #imageLiteral(resourceName: "upload"), tag: 1)
        
    }
}

extension MainTabBarController: UserServiceListener {
    func userSignedOut() {
        guard loginVC.view.window == nil else {
            return
        }
        
        if let vc = selectedViewController?.navigationController {
            if vc.view.window != nil {
                print("listener")
                self.present(loginVC, animated: true, completion: nil)
            }
        }
    }
}

