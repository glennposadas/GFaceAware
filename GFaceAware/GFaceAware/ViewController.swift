//
//  ViewController.swift
//  GFaceAware
//
//  Created by Glenn Posadas on 3/30/17.
//  Copyright © 2017 Citus Labs. All rights reserved.
//

import CoreImage
import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    // MARK: - Functions
    // MARK: IBAction
    
    @IBAction func newImage(_ sender: Any) {
        if let button_EditProfilePhoto = sender as? UIButton {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            // provide the view source
            alertController.popoverPresentationController?.sourceView = button_EditProfilePhoto
            alertController.popoverPresentationController?.sourceRect = button_EditProfilePhoto.bounds
            alertController.view.tintColor = .black
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
                    _ in
                    
                    alertController.view.tintColor = .black
                    
                    self.imagePicker.sourceType = .camera
                    
                })
                
                alertController.addAction(cameraAction)
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {
                    _ in
                    
                    alertController.view.tintColor = .black
                    self.imagePicker.sourceType = .photoLibrary
                    
                })
                
                alertController.addAction(photoLibraryAction)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
    }
}

// MARK: Image Picker Delegate

extension ViewController: UIPickerViewDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // Without BetterFace
            
            self.imageView1.image = image
            
            // With BetterFace.
            
            self.imageView2.needsBetterFace = true
            self.imageView2.fast = false
            self.imageView2.setBetterFaceImage(image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

