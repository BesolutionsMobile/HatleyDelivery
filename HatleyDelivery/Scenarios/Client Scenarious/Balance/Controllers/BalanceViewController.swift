//
//  BalanceViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 11/4/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BalanceViewController: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var fromEarnedLabel: UILabel!
    @IBOutlet weak var promotedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getBalance()
    }
    

    func getBalance()
    {
        
        self.startAnimating()

            DispatchQueue.global(qos: .userInteractive).async {
                // Test Login request
                APIClient.getBalance(completion: { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            print(response)
                            
                            self.stopAnimating()
                            
                            self.creditLabel.text = String(response.data.credit)
                            self.fromEarnedLabel.text = String(response.data.fromEarned)
                            self.promotedLabel.text = String(response.data.promotedValue)
                    
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        
                        self.stopAnimating()
                    }
                })
                
            }
            
            
        }
    
}
