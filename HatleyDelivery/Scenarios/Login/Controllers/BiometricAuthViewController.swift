//
//  BiometricAuthViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 11/4/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import BiometricAuthentication

class BiometricAuthViewController: UIViewController {

    
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var faceIDStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if BioMetricAuthenticator.shared.faceIDAvailable() {
            
            bg.image = UIImage(named: "Gradient Fill 1")
            
        }else
        {
            faceIDStack.isHidden = true
        }
        
        biometricauth()
    }

    
    func biometricauth()
    {

        BioMetricAuthenticator.authenticateWithBioMetrics(reason: "") { (result) in
            
            switch result {
            case .success( _):
                print("Authentication Successful")
                
                self.apply()
                
            case .failure( _):
                print("Authentication Failed")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        exit(0)
                    }
                }
            }
        }
        
    }
    
    
    func apply()
    {
        
        if(UserDefault.getType() == 1)
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

}
