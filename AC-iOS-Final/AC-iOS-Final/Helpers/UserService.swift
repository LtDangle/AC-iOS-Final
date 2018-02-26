//
//  UserService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseAuth
//+ `FIRAuthErrorCodeInvalidEmail` - Indicates the email address is malformed. + `FIRAuthErrorCodeEmailAlreadyInUse` - Indicates the email used to attempt sign up already exists. Call fetchProvidersForEmail to check which sign-in mechanisms the user used, and prompt the user to sign in with one of those. + `FIRAuthErrorCodeOperationNotAllowed` - Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console. + `FIRAuthErrorCodeWeakPassword` - Indicates an attempt to set a password that is considered too weak. The NSLocalizedFailureReasonErrorKey field in the NSError.userInfo dictionary object will contain more detailed explanation that can be shown to the user.
enum UserError: Error {
    case invalidEmail
    case emailAlreadyInUse
    case consoleRestricted
    case weakPassword
    case wrongPassword
    case userDisabled
    case otherError
    case userNotVerified
    case userNotFound
}

enum SignInError: Error {
    case consoleRestricted
    case invalidEmail
    case userDisabled
    case wrongPassword
    case userNotVerified
    case otherError
}



protocol UserServiceListener: class {
    func userSignedOut() -> Void
}

class UserService {
    private init(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // signed in
                print("signed in")
            } else {
                // signed out
                print("signed out")
                self.currentUser = nil
            }
        }
    }
    static let manager = UserService()
    
    private var currentUser: User? {
        didSet {
            if currentUser == nil {
                self.userListener?.userSignedOut()
            }
        }
    }
    // should only be used as a back up if a user is abruptly signed out
    public weak var userListener: UserServiceListener?
    
    // MARK: API
    public func createUser(_ email: String, withPassword pw: String, completion: @escaping ((_ success: Bool, _ error: UserError?) -> Void) = {_,_ in } ) {
        Auth.auth().createUser(withEmail: email, password: pw) { (user, error) in
            if let error = error,
                let errCode = AuthErrorCode(rawValue: error._code) {
                switch errCode {
                case .invalidEmail: completion(false, UserError.invalidEmail); return
                case .emailAlreadyInUse: completion(false, UserError.emailAlreadyInUse); return
                case .operationNotAllowed: completion(false, UserError.consoleRestricted); return
                case .weakPassword: completion(false, UserError.weakPassword); return
                default: completion(false, UserError.otherError); return
                }
            }
            if let user = user {
                user.sendEmailVerification(completion: { (error) in
                    if let _ = error {
                        completion(false, UserError.userNotFound); return
                    }
                    completion(true, nil)
                })
            }
        }
    }
    
    public func signIn(_ email: String, withPassword pw: String, completion: @escaping (_ success: Bool, _ error: SignInError?) -> Void = {_,_ in } ) {
        Auth.auth().signIn(withEmail: email, password: pw) { (user, error) in
            if let error = error,
                let errCode = AuthErrorCode(rawValue: error._code){
                switch errCode {
                case .operationNotAllowed: completion(false, SignInError.consoleRestricted); return
                case .invalidEmail: completion(false, SignInError.invalidEmail); return
                case .userDisabled: completion(false, SignInError.userDisabled); return
                case .wrongPassword: completion(false, SignInError.wrongPassword); return
                default: completion(false, SignInError.otherError); return
                }
            }
            if let user = user {
                if !user.isEmailVerified {
                    completion(false, SignInError.userNotVerified); return
                }
                completion(true, nil)
            }
        }
        
        
    }
    public func signOut(completion: ((_ success: Bool, _ error: Error?) -> Void) = {_,_  in } ) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        } catch {
            completion(false, error)
            
        }
    }
    public func getCurrentUser() -> User? {
        if let currentUser = currentUser {
            return currentUser
        }
        if let FIRUser = Auth.auth().currentUser {
//            let currentUser = User.init(uid: FIRUser.uid, name: FIRUser.displayName ?? "", isVerified: FIRUser.isEmailVerified)
            currentUser = FIRUser
            return currentUser
        }
        return nil
    }
    public func userIsSignedIn() -> Bool {
        return getCurrentUser() != nil
    }
    
}
