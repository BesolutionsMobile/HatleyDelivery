//
//  ShareAndEarnViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 11/4/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit

class ShareAndEarnViewController: UIViewController {

    @IBOutlet weak var promoCode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        promoCode.text = UserDefault.getPromoCode()
    }
    @IBAction func shareClicked(_ sender: Any) {
        
        share(string: promoCode.text!)
    }
    
    func share(string:String)
    {
        
        // text to share
               let text = string

               // set up activity view controller
               let textToShare = [ text ]
               let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
               activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

               // present the view controller
               self.present(activityViewController, animated: true, completion: nil)
        
    }
    
}
