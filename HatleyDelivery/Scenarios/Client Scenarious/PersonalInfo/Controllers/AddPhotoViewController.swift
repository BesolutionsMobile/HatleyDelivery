//
//  AddPhotoViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 11/6/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var userImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    var imgURL:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgURL = "image"
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let tap16 = UITapGestureRecognizer(target: self, action: #selector(AddPhotoViewController.identityClick))
        userImage.addGestureRecognizer(tap16)
        userImage.isUserInteractionEnabled = true
    }
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func identityClick()
    {
        
        let alert = UIAlertController(title: "Choose Picture", message: "Choose From Album", preferredStyle: .actionSheet)
        
        let album = UIAlertAction(title: "Choose From Album", style: .default, handler: {
            (action) -> Void in
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action) -> Void in
        })
        
        alert.addAction(album)
        alert.addAction(cancel)
        
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          
          let finalDownloadLink = FirebaseUploader.uploadToFirebase(viewController: self, imagePicker: picker, didFinishPickingMediaWithInfo: info)
          
          self.imgURL = finalDownloadLink
          
          let image = info[.originalImage] as? UIImage
          
          userImage.image = image
          userImage.contentMode = .scaleAspectFill
      
    }
    
    
    @IBAction func saveClicked(_ sender: Any) {
        
        changeImage()
    }
    
    
    func changeImage()
    {
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.changePhoto(image_url: self.imgURL!, completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        
                        print(response)
                        
                        Alert.show("Update Image", massege: "User Photo Updated", context: self)
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            })
            
        }
        
        
    }
    
}
