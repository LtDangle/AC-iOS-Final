//
//  ImageCache.swift
//  CatOrDog
//
//  Created by C4Q on 12/19/17.
//  Copyright © 2017 C4Q. All rights reserved.
//
// This is a singleton to manage our NSCache onjects
// NSCache saves temporary files in the caches directory


import UIKit

class ImageCache {
    private init() {}
    static let manager = ImageCache()
    
    private let sharedCached = NSCache<NSString, UIImage>()
    
    // get current cached image
    func cachedImage(url: URL) -> UIImage? {
        return sharedCached.object(forKey: url.absoluteString as NSString)
    }
    
    // process image and store in cache
    func processImageInBackground(imageURL: URL, completion: @escaping(Error?, UIImage?) -> Void) {
        DispatchQueue.global().async {
            do {
                let imageData = try Data.init(contentsOf: imageURL)
                let image = UIImage.init(data: imageData)
                
                // store image in cache
                if let image = image {
                    self.sharedCached.setObject(image, forKey: imageURL.absoluteString as NSString)
                }
                
                
                completion(nil, image)
            } catch {
                print("image processing error: \(error.localizedDescription)")
                completion(error, nil)
            }
        }
    }
    
    
    
}

