//
//  DatabaseService+Post.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//


import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import UIKit

extension DatabaseService {
    
    
    private func upload(image: UIImage, withPostRef ref: DatabaseReference, completion: @escaping (_ success: Bool, _ error: Error?) -> Void = {_,_ in}) {
        guard let data = UIImageJPEGRepresentation(image, 0.5) else {
            // TODO: handle this error
            print("couldn't turn image into data")
            return
        }
        let imageRef = storageRef().child(ref.key)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let uploadTask = imageRef.putData(data, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                // TODO: handle error
                // Uh-oh, an error occurred!
                print("couldn't upload")
                return
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            // A progress event occured
            if let progress = snapshot.progress {
                print(progress.fractionCompleted)
            }
        }
        uploadTask.observe(.success) { (snapshot) in
            completion(true, nil)
        }
        
        uploadTask.observe(.failure) { (snapshot) in
            if let error = snapshot.error as? NSError {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
                
                completion(false, error)
            }
            
            // TODO: pass error all the way back up to view controller
            print("failure")
        }
    }
    
    // API
    public func uploadNewPost(_ comment: String, withImage image: UIImage, completion: @escaping (_ success: Bool, _ error: Error?) -> Void = {_,_ in}) {
        guard let user = UserService.manager.getCurrentUser() else { return }
        let newPostRef = self.dbRef().child("posts").childByAutoId()
        
        let value: [String: Any] = ["comment": comment,
                                    "userID": UserService.manager.getCurrentUser()!.uid]
        let uploadedImage: (Bool, Error?) -> Void = { success, error in
            if success {
                newPostRef.setValue(value)
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
        upload(image: image, withPostRef: newPostRef, completion: uploadedImage)
    }
    
    public func getPosts(completion: @escaping (_ posts: [Post]?, _ error: Error?) -> Void = {_,_ in}) {
        dbRef().child("posts").observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            var commentAndImageKey = [(String, String)]()
            var images = [Int: UIImage]()
            
            var posts = [Post]()
            for snap in snapshot.children {
                if let postSnap = snap as? DataSnapshot {
                    var id = postSnap.key
                    var comment = ""
                    if let dict = postSnap.value as? [String: AnyObject] {
                        comment = dict["comment"] as? String ?? ""
                    }
                    let post = Post(id: id, comment: comment)
                    posts.append(post)
                }
            }
            completion(Array(posts.reversed()), nil)
        }) { (error) in
            completion(nil, error)
        }
    }
    
    public func getImage(fromKey key: String, completion: @escaping (UIImage?, Error?) -> Void) {
        // Create a reference to the file you want to download
        let imageRef = storageRef().child(key)
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                completion(nil, error)
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                completion(image, nil)
            }
        }
    }
    
    
}
