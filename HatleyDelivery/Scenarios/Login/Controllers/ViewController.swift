//
//  ViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/9/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import FirebaseMessaging
import Firebase
import FacebookCore
import FacebookLogin
import FBSDKCoreKit
import BEMCheckBox

class ViewController: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var usernameTextField: DesignableUITextField!
    @IBOutlet weak var passwordTextField: DesignableUITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var biometricauthSwitch: BEMCheckBox!
    
    var token:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designStuff()
        
        retriveToken()
        
        if(biometricauthSwitch.on)
        {
            UserDefault.enableFingerPrint()
        }else
        {
            UserDefault.disableFingerPrint()
        }
    
    }
    
    func retriveToken()
    {
        
        InstanceID.instanceID().instanceID { (result, error) in
        if let error = error {
        print("Error fetching remote instange ID: \(error)")
        } else if let result = result {
            self.token = result.token
        print("Remote instance ID token: \(result.token)")
         }
        }
        
    }
    
    func designStuff()
    {
        signInButton.layer.cornerRadius = 15.0
        facebookButton.layer.cornerRadius = 15.0
        usernameTextField.layer.cornerRadius = 15.0
        usernameTextField.layer.borderWidth = 2.0
        usernameTextField.layer.borderColor = UIColor.gray.cgColor
        usernameTextField.borderStyle = .none
        
        passwordTextField.layer.cornerRadius = 15.0
        passwordTextField.layer.borderWidth = 2.0
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.borderStyle = .none
        
    }
    
    @IBAction func newAccount(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        
        newViewController.modalPresentationStyle = .fullScreen
        
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func signinClicked(_ sender: Any) {
        
        login(email: self.usernameTextField.text!,password: self.passwordTextField.text!)
        //user_details()
    }
    
    
    @IBAction func facebookClicked(_ sender: Any) {
        
        facebook()
    }
    
    func user_details()
    {
        
        self.startAnimating()
    
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.user_details(completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        print(response.success.createdAt)
                        
                        self.stopAnimating()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            })
            
        }
        
        
    }

    func login(email:String,password:String){
        
        self.startAnimating()
    
        retriveToken()
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.login(email: email, password: password,mobile_token: self.token!, completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        print(response)
                        
                        UserDefault.setLogin()
                        
                        UserDefault.setID(response.user.id)
                        UserDefault.setName(response.user.name)
                        UserDefault.setEmail(response.user.email)
                        UserDefault.setToken(response.token)
                        UserDefault.setType(response.user.userTypeID)
                        
                        UserDefault.setMobile(response.user.phone ?? "000")
                        
                        UserDefault.setPromoCode(response.user.code)
                        
                         self.stopAnimating()
                        
                        if(response.user.userTypeID == 1)
                        {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainClientViewController") as! MainClientViewController
                            
                            newViewController.modalPresentationStyle = .fullScreen
                            
                            self.present(newViewController, animated: true, completion: nil)
                        }else
                        {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainStarViewController") as! MainStarViewController
                            
                            newViewController.modalPresentationStyle = .fullScreen
                            
                            self.present(newViewController, animated: true, completion: nil)
                        }
                        
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                    self.stopAnimating()
                    
                    Alert.show("Login", massege: "Login Failed", context: self)
                }
            })
            
        }
    }
    
    func registration(name:String,email:String,password:String,userImage:String){
        
        self.startAnimating()
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.registration(name: name, email: email, password: password, confirm: password,mobile_token: self.token!, image_id: userImage, completion: { result in
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
                    
                    self.login(email: email, password: password)
                }
            })
            
        }
    }
    
    
    func facebook()
    {
        let loginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [ .publicProfile , .email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(_ , _ , _):
                print("Logged in!")
                FBProfileRequest().start { _, result in
                    switch result {
                    case .failed:
                        return
                    case .success(response:let response):
                        
                        var userName:String
                        var userEmail:String
                        
                        
                        if(response.email != "" && response.email != nil){
                            
                            userEmail = response.email!
                            
                        print("--------------------------------------------------------------------------------------------------------------------")
                            print(userEmail)
                            print("--------------------------------------------------------------------------------------------------------------------")
                            
                            userName = response.name!
                            
                            print("--------------------------------------------------------------------------------------------------------------------")
                            print(userName)
                            print("--------------------------------------------------------------------------------------------------------------------")
                            
                            self.registration(name: userName, email: userEmail, password: response.facebookId!, userImage: response.picUrl!)
                            
                        }
                        
                    }
                }
            }
        }
        
    }

}

