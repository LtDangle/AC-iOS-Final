//
//  DatabaseService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DatabaseService {
    private init(){
        
        ref = Database.database().reference()
        storage = Storage.storage().reference()
    }
    static let manager = DatabaseService()
    
    private var ref: DatabaseReference!
    private var storage: StorageReference!
    public func dbRef() -> DatabaseReference {
        return ref
    }
    public func storageRef() -> StorageReference {
        return storage
    }
    
}
