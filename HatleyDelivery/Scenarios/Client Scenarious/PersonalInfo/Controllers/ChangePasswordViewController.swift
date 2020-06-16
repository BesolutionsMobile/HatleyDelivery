//
//  ChangePasswordViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 11/6/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        
        if(passwordTextField.text == confirmTextField.text)
        {
            changePassword()
        }else
        {
            Alert.show("Password", massege: "Password Not Matched", context: self)
        }
    }
    
    
    func changePassword()
    {
    
        let password = confirmTextField.text
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.changePassword(password: password!, password_confirmation: password!, completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        
                        print(response)
                        
                        Alert.show("Password Change", massege: "Password Updated", context: self)
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            })
            
        }
        
        
    }

}
