//
//  PromoCodeViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 11/4/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PromoCodeViewController: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var promoCodeLabel: UILabel!
    @IBOutlet weak var promoCodeTextField: UITextField!
    @IBOutlet weak var promoCodeDiscountMainLabel: UILabel!
    @IBOutlet weak var promoCodeDiscountLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        promoCodeDiscountMainLabel.isHidden = true
        promoCodeDiscountLabel.isHidden = true
    }
    
    
    @IBAction func saveClicked(_ sender: Any) {
        
        promoCodeFucntion()
    }
    
    func promoCodeFucntion()
       {
           
        self.startAnimating()
        
        let promocode = promoCodeTextField.text
       
           DispatchQueue.global(qos: .userInteractive).async {
               // Test Login request
            APIClient.promoCode(promoCode: promocode!,completion: { result in
                   switch result {
                   case .success(let response):
                       DispatchQueue.main.async {
                           
                        print(response)
                        
                        if(response.codeInfo.discountAmount == 0)
                        {
                            Alert.show("Promo Code", massege: response.message, context: self)
                        }else
                        {
                            self.promoCodeDiscountMainLabel.isHidden = false
                            self.promoCodeDiscountLabel.isHidden = false
                            
                            let final = String(response.codeInfo.discountAmount)
                            
                            self.promoCodeDiscountLabel.text = "You Will Enjoy a " + final + " EGP Discount"
                        }
                        
                        
                           self.stopAnimating()
                       }
                   case .failure(let error):
                       print(error.localizedDescription)
                       
                   }
               })
               
           }
           
           
       }
}
