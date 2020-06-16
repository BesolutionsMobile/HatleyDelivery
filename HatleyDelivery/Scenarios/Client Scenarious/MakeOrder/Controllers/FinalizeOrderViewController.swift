//
//  FinalizeOrderViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/21/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class FinalizeOrderViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NVActivityIndicatorViewable {

    var orderPlace:String?
    var deleviryPlace:String?
    
    var orderPlaceLat:Double?
    var orderPlaceLong:Double?
    var deleviryPlaceLat:Double?
    var deleviryPlaceLong:Double?
    
    var distance:Double?
    
    var duration:Double?
    
    @IBOutlet weak var deleviryTimeView: UIView!
    @IBOutlet weak var coponCodeView: UIView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var orderimage: UIImageView!
    @IBOutlet weak var deliveryTime: UITextField!
    @IBOutlet weak var coponCode: UITextField!
    
    @IBOutlet weak var orderButton: UIButton!
    
    let datePicker = UIDatePicker()
    
    var imagePicker: UIImagePickerController!
    
    var imgURL:String?
    
    var deliveryTimeText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        duration = distance! * 0.65
        
        imgURL = "image"
        
        showDatePicker()
        
        print(UserDefault.getToken())
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
     //   NotificationCenter.default.addObserver(self, selector: #selector(handleFinish), name: .saveDateTime, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        designStuff()
    }
    
    func designStuff()
    {
        
        self.descriptionTextField.layer.borderWidth = 1.0
        self.descriptionTextField.layer.borderColor = #colorLiteral(red: 0.09803921569, green: 0.4745098039, blue: 0.3215686275, alpha: 1)
        self.descriptionTextField.layer.cornerRadius = 10.0
        self.descriptionTextField.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        self.deleviryTimeView.layer.cornerRadius = 10.0
        self.coponCodeView.layer.cornerRadius = 10.0
        self.deliveryTime.layer.cornerRadius = 10.0
        self.coponCode.layer.cornerRadius = 10.0
        
        self.orderButton.layer.cornerRadius = 10.0
        
        self.orderimage.layer.borderWidth = 1.0
        self.orderimage.layer.cornerRadius = 10.0
        self.orderimage.layer.borderColor = #colorLiteral(red: 0.09803921569, green: 0.4745098039, blue: 0.3215686275, alpha: 1)
        
        
        let tap16 = UITapGestureRecognizer(target: self, action: #selector(FinalizeOrderViewController.identityClick))
        orderimage.addGestureRecognizer(tap16)
        orderimage.isUserInteractionEnabled = true
        
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
    
    
    @IBAction func orderClick(_ sender: Any) {
        
        let orderDescription = descriptionTextField.text
        let orderDelvieryTime = deliveryTimeText
        print(orderDelvieryTime!)
        
        guard let client_location_lat = self.deleviryPlaceLat else { return }
        let client_location_lat_str = String(client_location_lat)
        
        guard let client_location_long = self.deleviryPlaceLong else { return }
        let client_location_long_str = String(client_location_long)
        
        guard let order_location_lat = self.orderPlaceLat else { return }
        let order_location_lat_str = String(order_location_lat)
        
        guard let order_location_long = self.orderPlaceLong else { return }
        let order_location_long_str = String(order_location_long)
        
        if(orderDescription!.count > 10)
        {
            if(deliveryTime.text!.isEmpty)
            {
                Alert.show("Ordering Error", massege: "Enter Delivery Time First", context: self)
            }else
            {
                self.startAnimating()
                
                DispatchQueue.global(qos: .userInteractive).async {
                    // Test Login request
                    APIClient.publish_order(order_description: orderDescription!, image: self.imgURL!, distance: self.distance!.description, duration: self.duration!.description, promo_code: "", delivery_time: orderDelvieryTime!, order_from_location: self.orderPlace!, order_to_location: self.deleviryPlace!, client_location_lat: client_location_lat_str, client_location_long: client_location_long_str, order_location_lat: order_location_lat_str,order_location_long: order_location_long_str, mobile_token: UserDefault.getToken(),completion: { result in
                        switch result {
                        case .success(let response):
                            DispatchQueue.main.async {
                                print(response)
                                
                                self.stopAnimating()
                                
                                let alertController = UIAlertController(title:"Publish Order", message: "Order Published Sucessfully", preferredStyle:.alert)
                                
                                UserDefault.activateOrder()

                                let Action = UIAlertAction.init(title: "Ok", style: .default) { (UIAlertAction) in
                                    
                                    self.navigationController?.popToRootViewController(animated: true)
                                }

                                alertController.addAction(Action)
                                self.present(alertController, animated: true, completion: nil)
                                
                                print(response.order.id)
                                UserDefault.setorderID(String(response.order.id))
                            UserDefault.setorderDeliveryTime(response.order.deliveryTime)
                                
                                
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            
                            Alert.show("Ordering Error", massege: "Error in Submittion", context: self)
                             self.stopAnimating()
                        }
                    })
                    
                }
            }
        }else
        {
            Alert.show("Ordering Error", massege: "Description is too Short", context: self)
        }
        
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .time
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        deliveryTime.inputAccessoryView = toolbar
        deliveryTime.inputView = datePicker
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        dismiss(animated: true, completion: nil)
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "hh:mm a"
        
        deliveryTime.text = formatter2.string(from: datePicker.date)
        
        deliveryTimeText = formatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "hh:mm a"
        return  dateFormatter.string(from: date!)

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          
          let finalDownloadLink = FirebaseUploader.uploadToFirebase(viewController: self, imagePicker: picker, didFinishPickingMediaWithInfo: info)
          
          self.imgURL = finalDownloadLink
          
          let image = info[.originalImage] as? UIImage
          
          orderimage.image = image
          orderimage.contentMode = .scaleAspectFill
      
    }

}
