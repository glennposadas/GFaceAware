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
    
    typealias AlertControllerCallBack = (_ sourceType: UIImagePickerControllerSourceType) -> Void
    
    // MARK: - Functions
    // MARK: IBAction
    
    @IBAction func newImage(_ sender: Any) {
        if let button_EditProfilePhoto = sender as? UIButton {
            self.showAlertControllerForPhoto(sourceView: button_EditProfilePhoto) {
                [weak self] (sourceType) in
                
                guard let strongSelf = self else { return }
                
                strongSelf.imagePicker.sourceType = sourceType
                strongSelf.navigationController?.present(strongSelf.imagePicker, animated: true, completion: nil)
            }
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

extension ViewController: UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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

// MARK: AlertController Setup

extension ViewController {
    func showAlertControllerForPhoto(sourceView: UIView, withBlock completion: @escaping AlertControllerCallBack) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // provide the view source
        alertController.popoverPresentationController?.sourceView = sourceView
        alertController.popoverPresentationController?.sourceRect = sourceView.bounds
        alertController.view.tintColor = .black
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
                _ in
                
                alertController.view.tintColor = .black
                completion(.camera)
                
            })
            
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {
                _ in
                
                alertController.view.tintColor = .black
                completion(.photoLibrary)
                
            })
            
            alertController.addAction(photoLibraryAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

