//
//  LoginView.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    
    var containerScrollView = UIScrollView()
    var signInPage = UIView()
    var signInEmailTextField = UITextField()
    var signInPWTextField = UITextField()
    var signInButton = UIButton()
    var goToSignUpButton = UIButton()
    var signUpPage = UIView()
    var signUpEmailTextField = UITextField()
    var signUpPWTextField = UITextField()
    var signUpVerifyPWTextField = UITextField()
    var signUpButton = UIButton()
    var goToSignInButton = UIButton()
    var logoImageView = UIImageView()
    
    
    
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
        setupContainerScrollView()
        setupLogoImageView()
            setupSignInPage()
            setupSignUpPage()
                //--------- Sign in
                setupSignInEmailTextField()
                setupSignInPWTextField()
                setupSignInButton()
                setupGoToSignUpButton()
                //--------- Sign up
                setupSignUpEmailTextField()
                setupSignUpPWTextField()
                setupSignUpVerifyPWTextField()
                setupSignUpButton()
                setupGoToSignInButton()
        
    }
    // Top Layer of main view
    private func setupContainerScrollView() {
        containerScrollView.isScrollEnabled = false
        containerScrollView.bounces = false
        self.addSubview(containerScrollView)
        containerScrollView.translatesAutoresizingMaskIntoConstraints = false
        [containerScrollView.topAnchor.constraint(equalTo: self.topAnchor),
         containerScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         containerScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         containerScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)]
            .forEach{$0.isActive = true}
        
    }
    private func setupLogoImageView() {
        logoImageView.image = #imageLiteral(resourceName: "meatly_logo")
        logoImageView.contentMode = .scaleAspectFit
        
        var ratio: CGFloat = 1.0
        if let size = logoImageView.image?.size {
            ratio = size.height / size.width
        }
        self.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        [logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
         logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
         logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor, multiplier: ratio)]
            .forEach{$0.isActive = true}
        
        
    }
    // Within ScrollView
    private func setupSignInPage() {
//        signInPage.backgroundColor = .cyan
        
        containerScrollView.addSubview(signInPage)
        signInPage.translatesAutoresizingMaskIntoConstraints = false
        
        // Size Constraints
        [signInPage.heightAnchor.constraint(equalTo: containerScrollView.heightAnchor),
         signInPage.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor)]
            .forEach{$0.isActive = true}
        
        // ScrollView Content Constraints
        [signInPage.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor),
         signInPage.topAnchor.constraint(equalTo: containerScrollView.topAnchor),
         signInPage.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor)]
            .forEach{$0.isActive = true}
        // Trailing constraint is in signUp page
    }
    private func setupSignUpPage() {
//        signUpPage.backgroundColor = .green
        
        containerScrollView.addSubview(signUpPage)
        signUpPage.translatesAutoresizingMaskIntoConstraints = false
        
        // Size (+ position) Constraints
        [signUpPage.heightAnchor.constraint(equalTo: containerScrollView.heightAnchor),
         signUpPage.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor),
         signUpPage.leadingAnchor.constraint(equalTo: signInPage.trailingAnchor),
         signUpPage.centerYAnchor.constraint(equalTo: signInPage.centerYAnchor)]
            .forEach{$0.isActive = true}
        
        // ScrollView Content Trailing Constraint
        signUpPage.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor).isActive = true
    }
    
    // Within SignIn Page
    private func setupSignInEmailTextField() {
        signInEmailTextField.placeholder = "Email"
        signInEmailTextField.borderStyle = .roundedRect
        signInEmailTextField.clearButtonMode = .whileEditing
        signInEmailTextField.autocorrectionType = .no
        signInEmailTextField.autocapitalizationType = .none
        signInEmailTextField.backgroundColor = .lightGray
        
        signInPage.addSubview(signInEmailTextField)
        signInEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        [signInEmailTextField.centerXAnchor.constraint(equalTo: signInPage.centerXAnchor),
         signInEmailTextField.centerYAnchor.constraint(equalTo: signInPage.centerYAnchor),
         signInEmailTextField.widthAnchor.constraint(equalTo: signInPage.widthAnchor, multiplier: 0.7)]
            .forEach{$0.isActive = true}
        
    }
    private func setupSignInPWTextField() {
        signInPWTextField.placeholder = "Password"
        signInPWTextField.isSecureTextEntry = true
        signInPWTextField.borderStyle = .roundedRect
        signInPWTextField.clearButtonMode = .whileEditing
        signInPWTextField.autocorrectionType = .no
        signInPWTextField.autocapitalizationType = .none
        signInPWTextField.backgroundColor = .lightGray
        
        signInPage.addSubview(signInPWTextField)
        signInPWTextField.translatesAutoresizingMaskIntoConstraints = false
        [signInPWTextField.centerXAnchor.constraint(equalTo: signInEmailTextField.centerXAnchor),
         signInPWTextField.topAnchor.constraint(equalTo: signInEmailTextField.bottomAnchor, constant: 16),
         signInPWTextField.widthAnchor.constraint(equalTo: signInEmailTextField.widthAnchor)]
            .forEach{$0.isActive = true}
        
    }
    private func setupSignInButton() {
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.setTitleColor(.blue, for: .normal)
        
        signInPage.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        [signInButton.centerXAnchor.constraint(equalTo: signInPWTextField.centerXAnchor),
         signInButton.topAnchor.constraint(equalTo: signInPWTextField.bottomAnchor, constant: 16)]
            .forEach{$0.isActive = true}
    }
    private func setupGoToSignUpButton(){
        goToSignUpButton.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        goToSignUpButton.setTitle("Need an account? | Sign Up", for: .normal)
        goToSignUpButton.setTitleColor(.black, for: .normal)
        
        
        signInPage.addSubview(goToSignUpButton)
        goToSignUpButton.translatesAutoresizingMaskIntoConstraints = false
        [goToSignUpButton.trailingAnchor.constraint(equalTo: signInPage.trailingAnchor, constant: -16),
         goToSignUpButton.bottomAnchor.constraint(equalTo: signInPage.bottomAnchor, constant: -16)].forEach{$0.isActive = true}
        
    }
    
    
    // Within SignUp Page
    private func setupSignUpEmailTextField() {
        signUpEmailTextField.placeholder = "Email"
        signUpEmailTextField.borderStyle = .roundedRect
        signUpEmailTextField.clearButtonMode = .whileEditing
        signUpEmailTextField.autocorrectionType = .no
        signUpEmailTextField.autocapitalizationType = .none
        signUpEmailTextField.backgroundColor = .lightGray
        
        signUpPage.addSubview(signUpEmailTextField)
        signUpEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        [signUpEmailTextField.centerXAnchor.constraint(equalTo: signUpPage.centerXAnchor),
         signUpEmailTextField.centerYAnchor.constraint(equalTo: signUpPage.centerYAnchor),
         signUpEmailTextField.widthAnchor.constraint(equalTo: signUpPage.widthAnchor, multiplier: 0.7)]
            .forEach{$0.isActive = true}
        
    }
    private func setupSignUpPWTextField() {
        signUpPWTextField.placeholder = "Password"
        signUpPWTextField.isSecureTextEntry = true
        signUpPWTextField.borderStyle = .roundedRect
        signUpPWTextField.clearButtonMode = .whileEditing
        signUpPWTextField.autocorrectionType = .no
        signUpPWTextField.autocapitalizationType = .none
        signUpPWTextField.backgroundColor = .lightGray
        
        signUpPage.addSubview(signUpPWTextField)
        signUpPWTextField.translatesAutoresizingMaskIntoConstraints = false
        [signUpPWTextField.centerXAnchor.constraint(equalTo: signUpEmailTextField.centerXAnchor),
         signUpPWTextField.topAnchor.constraint(equalTo: signUpEmailTextField.bottomAnchor, constant: 16),
         signUpPWTextField.widthAnchor.constraint(equalTo: signUpEmailTextField.widthAnchor)]
            .forEach{$0.isActive = true}
        
    }
    private func setupSignUpVerifyPWTextField() {
        signUpVerifyPWTextField.placeholder = "Verify Password"
        signUpVerifyPWTextField.isSecureTextEntry = true
        signUpVerifyPWTextField.borderStyle = .roundedRect
        signUpVerifyPWTextField.clearButtonMode = .whileEditing
        signUpVerifyPWTextField.autocorrectionType = .no
        signUpVerifyPWTextField.autocapitalizationType = .none
        signUpVerifyPWTextField.backgroundColor = .lightGray
        
        signUpPage.addSubview(signUpVerifyPWTextField)
        signUpVerifyPWTextField.translatesAutoresizingMaskIntoConstraints = false
        [signUpVerifyPWTextField.centerXAnchor.constraint(equalTo: signUpPWTextField.centerXAnchor),
         signUpVerifyPWTextField.topAnchor.constraint(equalTo: signUpPWTextField.bottomAnchor, constant: 16),
         signUpVerifyPWTextField.widthAnchor.constraint(equalTo: signUpPWTextField.widthAnchor)]
            .forEach{$0.isActive = true}
        
    }
    private func setupSignUpButton() {
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(.blue, for: .normal)
        
        signUpPage.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        [signUpButton.centerXAnchor.constraint(equalTo: signUpVerifyPWTextField.centerXAnchor),
         signUpButton.topAnchor.constraint(equalTo: signUpVerifyPWTextField.bottomAnchor, constant: 16)]
            .forEach{$0.isActive = true}
    }
    
    private func setupGoToSignInButton() {
        goToSignInButton.addTarget(self, action: #selector(goToSignIn), for: .touchUpInside)
        goToSignInButton.setTitle("Sign In | Already have an account?", for: .normal)
        goToSignInButton.setTitleColor(.black, for: .normal)
        
        
        signUpPage.addSubview(goToSignInButton)
        goToSignInButton.translatesAutoresizingMaskIntoConstraints = false
        [goToSignInButton.leadingAnchor.constraint(equalTo: signUpPage.leadingAnchor, constant: 16),
         goToSignInButton.bottomAnchor.constraint(equalTo: signUpPage.bottomAnchor, constant: -16)].forEach{$0.isActive = true}
    }
    
    
    // Helper functions to switch between pages
    @objc func goToSignIn() {
        containerScrollView.setContentOffset(signInPage.frame.origin, animated: true)
    }
    
    @objc func goToSignUp() {
        containerScrollView.setContentOffset(signUpPage.frame.origin, animated: true)
    }
}
