//
//  ChangePhoneViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 11/6/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit

class ChangePhoneViewController: UIViewController {

    
    @IBOutlet weak var phoneTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneTextfield.text = UserDefault.getMobile()
        
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        changePhone()
    }
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func changePhone()
    {
    
        let phone = phoneTextfield.text
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.changePhone(phone: phone!, completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        
                        print(response)
                        
                        Alert.show("Phone Number", massege: "Phone Number Updated", context: self)
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            })
            
        }
        
        
    }
    
}
