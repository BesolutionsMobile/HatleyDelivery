//
//  OfferDetailsViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/21/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import Cosmos
import Firebase
import FirebaseMessaging

class OfferDetailsViewController: UIViewController {

    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var starRate: CosmosView!
    @IBOutlet weak var starName: UILabel!
    @IBOutlet weak var starOrdersHistory: UILabel!
    
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var offerTime: UILabel!
    
    
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    var offerID:String?
    var orderID:String?
    
    var starNameStg:String?
    var starHistoryStg:String?
    var starRateDbl:Double?
    var starImgStg:String?
    
    var offerPriceStg:String?
    var offerTimeStg:String?
    
    var db:Firestore!
    
    var mobileToken:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        approveButton.layer.cornerRadius = 12
        rejectButton.layer.cornerRadius = 12
        dismissButton.layer.cornerRadius = 12
        
        db = Firestore.firestore()
        
        mobileToken = Messaging.messaging().fcmToken
        
        print(mobileToken!)
        
        updateRate()

        starRate.rating = starRateDbl!
        starName.text = starNameStg
        starOrdersHistory.text = starHistoryStg
        starImage.sd_setImage(with: URL(string: starImgStg!), placeholderImage: UIImage(named: "017-Portrait-Photography-Manchester.png"))
        
        offerTime.text = offerTimeStg
        offerPrice.text = offerPriceStg
        
        print(offerID!)
        print(orderID!)
    }
    
    func approve(){
        
        print(self.offerID!)
        
        mobileToken = Messaging.messaging().fcmToken
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            APIClient.acceptOffer(offerID: self.offerID!, mobile_token: self.mobileToken!, completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        print(response)
                        
                        if(response.contains("notAccepted"))
                        {
                            Alert.show("Not Accepted", massege: "Order Accepted From Another Star", context: self)
                        }else if(response.contains("Mobile Token Is Required"))
                        {
                            Alert.show("Not Accepted", massege: "Order has Problems", context: self)
                        }else{
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewChatViewController") as! NewChatViewController
                                                   
                            newViewController.modalPresentationStyle = .fullScreen
                                                   
                                                                     //newViewController.recivername = notificationsList[indexPath.row].sentFrom?.name
                                                   
                            newViewController.orderID = self.orderID
                            
                            newViewController.imageStg = self.starImgStg
                                                                     
                            newViewController.recivername = self.starNameStg
                                                                     
                            self.present(newViewController, animated: true, completion: nil)
                        }
                       
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            })
            
        }
    }
    
    func reject()
    {
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.rejectOffer(offerID: self.offerID!, completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        print(response)
                        
                        let alertController = UIAlertController(title:"Offer Rejected", message: "Offer Rejected Sucessfully", preferredStyle:.alert)

                        let Action = UIAlertAction.init(title: "Ok", style: .default) { (UIAlertAction) in
                            
                            self.dismiss(animated: true, completion: nil)
                            
                            NotificationCenter.default.post(name: .saveDateTime, object: nil)
                        }

                        alertController.addAction(Action)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            })
            
        }
        
    }
    
    
    func updateRate()
    {
        let conversation = ["name" : UserDefault.getName() + "-" + starNameStg!,
                            "sender" : UserDefault.getName(),
                     "receiver" : starNameStg!,
                     "receiverImage" : "",
                     "lastMessage" : "last",
                     "starFinish" : "No",
                     "timeStamp" : FieldValue.serverTimestamp()
            ] as [String : Any]

        self.db.collection("Conversations").document(UserDefault.getName() + "-" + starNameStg!).setData(conversation)
    }
    
    
    @IBAction func closeClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func approvePlusChat(_ sender: Any) {
        
        approve()
    }
    
    @IBAction func rejectClicked(_ sender: Any) {
        
        reject()
    }
    
    @IBAction func dismissClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
