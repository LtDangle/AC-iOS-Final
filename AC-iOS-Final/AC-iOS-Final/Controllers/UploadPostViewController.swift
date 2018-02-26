//
//  UploadPostViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class UploadPostViewController: UIViewController {
    
    var uploadView = UploadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blue
        self.navigationItem.title = "Upload"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        self.view.addSubview(uploadView)
        uploadView.translatesAutoresizingMaskIntoConstraints = false
        [uploadView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
         uploadView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
         uploadView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
         uploadView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)]
        .forEach{$0.isActive = true}
        
        uploadView.selectImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        
    }
    
    @objc private func done() {
        guard
            uploadView.selectImageButton.image(for: .normal) != #imageLiteral(resourceName: "camera_icon"),
            !uploadView.commentTextView.text.isEmpty else {
                // TODO: show alert
                return
        }
        if let image = uploadView.selectImageButton.image(for: .normal),
            let comment = uploadView.commentTextView.text {
            
            DatabaseService.manager.uploadNewPost(comment, withImage: image, completion: {[unowned self] (success, error) in
                if let error = error {
                    // TODO: show error alert
                    print("error \(error)")
                    return
                }
                if success {
                    print("success")
                    self.uploadView.selectImageButton.imageView?.contentMode = .center
                    self.uploadView.selectImageButton.setImage(#imageLiteral(resourceName: "camera_icon"), for: .normal)
                    self.uploadView.commentTextView.text = ""
                    // TODO: show success alert
                }
            })
        }
    }
    
    @objc private func selectImage() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    private func setImage(_ image: UIImage) {
        uploadView.selectImageButton.setImage(image, for: .normal)
        uploadView.selectImageButton.imageView?.contentMode = .scaleAspectFill
    }
}

extension UploadPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        setImage(image)
        dismiss(animated:true, completion: nil)
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//        setImage(image)
//        dismiss(animated:true, completion: nil)
//    }
}


