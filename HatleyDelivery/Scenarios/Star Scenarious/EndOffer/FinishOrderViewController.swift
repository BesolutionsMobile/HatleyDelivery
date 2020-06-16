//
//  FinishOrderViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/24/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import MapKit

class FinishOrderViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var bilAmountTextField: UITextField!
    
    var orderID:String?
    
    var clientPhoneNumber:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.orderID!)

        mapStuff()
    }
    
    func mapStuff()
    {
        
        let orderLocation = MKPointAnnotation()
        
        orderLocation.coordinate = CLLocationCoordinate2D(latitude: 30.050309, longitude: 31.340159)
        
        self.map.addAnnotation(orderLocation)
        
    }
    
    
    @IBAction func dismissClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func finishOrderFunction(){
        
        let billAmount = bilAmountTextField.text
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.finishOrder(orderID: self.orderID!, billAmount: billAmount!, mobile_token: UserDefault.getToken(), completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        
                        print(response)
                        
                        self.dismiss(animated: true, completion: nil)
    
                        let sentData:[String: String] = ["status": "finish"]
                        
                        NotificationCenter.default.post(name: .saveDateTime, object: nil,userInfo: sentData)
    
                    }
                case .failure(let error):
                    print(error)
                    Alert.show("Error", massege: "Please Try Again", context: self)
                    
                }
            })
            
        }
    }
    

    @IBAction func callClient(_ sender: Any) {
        
        if let url = URL(string: "tel://\(clientPhoneNumber ?? "ddg")"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    @IBAction func finishOrder(_ sender: Any) {
        
        finishOrderFunction()
    }
    
}
