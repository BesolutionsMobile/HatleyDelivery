//
//  RegistrationViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/21/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class RegistrationViewController: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var userNameTextField: DesignableUITextField!
    @IBOutlet weak var emailTextField: DesignableUITextField!
    @IBOutlet weak var passwordTextField: DesignableUITextField!
    @IBOutlet weak var confirmTextField: DesignableUITextField!
    
    @IBOutlet weak var createButton: UIButton!
    var firebaseToken:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        retriveToken()
        designStuff()
    }
    
    @IBAction func createAccountClick(_ sender: Any) {
     
        registration()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func retriveToken()
    {
        InstanceID.instanceID().instanceID { (result, error) in
        if let error = error {
        print("Error fetching remote instange ID: \(error)")
        } else if let result = result {
            self.firebaseToken = result.token
        print("Remote instance ID token: \(result.token)")
         }
            
        }
    }
    
    func designStuff(){
        
        userNameTextField.layer.cornerRadius = 15.0
        userNameTextField.layer.borderWidth = 2.0
        userNameTextField.layer.borderColor = UIColor.gray.cgColor
        userNameTextField.borderStyle = .none
        
        emailTextField.layer.cornerRadius = 15.0
        emailTextField.layer.borderWidth = 2.0
        emailTextField.layer.borderColor = UIColor.gray.cgColor
        emailTextField.borderStyle = .none
        
        passwordTextField.layer.cornerRadius = 15.0
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.borderStyle = .none
        
        confirmTextField.layer.cornerRadius = 15.0
        confirmTextField.layer.borderWidth = 2.0
        confirmTextField.layer.borderColor = UIColor.gray.cgColor
        confirmTextField.borderStyle = .none
        
        createButton.layer.cornerRadius = 15.0
    }
    
    func registration(){
        
        self.startAnimating()
        
        let name = userNameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let confirm = confirmTextField.text
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.registration(name: name!, email: email!, password: password!, confirm: confirm!,mobile_token: self.firebaseToken!, image_id: "", completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        print(response)
    
                        UserDefault.setToken(response.token)
                        UserDefault.setName(response.user.name)
                        
                        self.stopAnimating()
                        
                       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainClientViewController") as! MainClientViewController
                        
                        newViewController.modalPresentationStyle = .fullScreen
                        
                        self.present(newViewController, animated: true, completion: nil)
                        
                    }
                case .failure(let error):
                    print(error)
                    self.stopAnimating()
                    Alert.show("Registration", massege: "Error in Registration Process", context: self)
                    
                }
            })
            
        }
    }
    
}
