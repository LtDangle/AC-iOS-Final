//
//  LoginPageViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        self.view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        [loginView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
         loginView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
         loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
         loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)]
            .forEach{$0.isActive = true}
        
        hookUpLoginButtons()
    }
    
    // MARK: - Helper Functions
    private func hookUpLoginButtons() {
        loginView.signInButton.addTarget(self, action: #selector(attemptSignIn), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(attemptSignUp), for: .touchUpInside)
    }
    
    @objc private func attemptSignIn() {
        guard
            let email = loginView.signInEmailTextField.text,
            let pw = loginView.signInPWTextField.text else {
                // TODO: handle this case
                print("no text?")
                return
        }
        UserService.manager.signIn(email, withPassword: pw) { [unowned self] (success, error) in
            if let error = error {
                self.showAlert(withTitle: "Login Failed!", andMessage: "\(error)")
                // TODO: handle this error
                print("error: \(error)")
                return
            }
            if success {
                print("userSignIn")
                self.dismiss(animated: true, completion: nil)
                print()
            }
        }        
    }
    @objc private func attemptSignUp() {
        guard
            let email = loginView.signUpEmailTextField.text,
            let pw1 = loginView.signUpPWTextField.text,
            let pw2 = loginView.signUpVerifyPWTextField.text else {
                // TODO: handle this case
                print("no text?")
                return
        }
        // TODO: Handle this differently?
        guard pw1 == pw2 else { print("passwords do not match"); return }
        
        UserService.manager.createUser(email, withPassword: pw1) { [unowned self] (success, error) in
            if let error = error {
                self.showAlert(withTitle: "Sign Up Failed!", andMessage: "\(error)")
                // TODO: handle this error
                print("error: \(error)")
                return
            }
            if success {
                print("verification email sent to \(email)")
                // TODO: setup view function to do this
                self.loginView.containerScrollView.setContentOffset(self.loginView.signInPage.frame.origin, animated: true)
            }
        }
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
