//
//  GetOffersViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/21/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SDWebImage

class GetOffersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NVActivityIndicatorViewable {

    @IBOutlet weak var deleivryTime: UILabel!
    @IBOutlet weak var offerAccepted: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noPosts: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var cancel: UIButton!
    
    var orderID:String?
    var orderDeliveryTime:String?
    
    var offersList = Array<Offer>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //UserDefault.setorderID("12")
        
        self.orderID = UserDefault.getorderID()
        print(self.orderID!)
        
        bottomView.isHidden = true
        
        designStuff()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFinish), name: .saveDateTime, object: nil)

    }
    
    @objc func handleFinish(notification: Notification)
    {
        self.bottomView.isHidden = true
        
        self.getOffers()
    }
    
    func designStuff()
    {
       self.cancel.layer.cornerRadius = 10.0
       self.infoView.layer.cornerRadius = 10.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    
               self.navigationController?.navigationBar.isHidden = false
               
               self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.09803921569, green: 0.4745098039, blue: 0.3215686275, alpha: 1)
               self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
               
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
               


        
        self.tableView.tableFooterView = UIView()
        offersList.removeAll()
        getOffers()
    }

    @IBAction func cancelOrder(_ sender: Any) {
        
        cancelOrder()
    }
    
    func getOffers(){
        
        self.startAnimating()
        noPosts.isHidden = true
        
        offersList.removeAll()
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.getOffers(completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        print(response)
                        
                        if(response.offers.isEmpty)
                        {
                            if(UserDefault.isOrderActive())
                            {
                                self.orderID = UserDefault.getorderID()
                                self.orderDeliveryTime = self.convertDateFormater(UserDefault.getorderDeliveryTime())
                                       
                                self.deleivryTime.text = self.orderDeliveryTime
                                
                                self.bottomView.isHidden = false
                                self.tableView.isHidden = true
                                
                                self.noPosts.isHidden = false
                            }else
                            {
                                self.bottomView.isHidden = true
                                self.tableView.isHidden = true
                                
                                self.noPosts.isHidden = false
                            }
                            
                            self.stopAnimating()
                            
                            
                        }else
                        {
                            
                            self.orderDeliveryTime = self.convertDateFormater(UserDefault.getorderDeliveryTime())
                                   
                            self.deleivryTime.text = self.orderDeliveryTime
                            
                            for i in 0...response.offers.count - 1 {
                                
                                self.offersList.append(response.offers[i])
                                
                            }
                            
                            self.tableView.reloadData()
                            self.tableView.isHidden = false
                            self.bottomView.isHidden = false
                            self.stopAnimating()
                        }
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.stopAnimating()
                    
                    self.bottomView.isHidden = true
                    self.tableView.isHidden = true
                    self.stopAnimating()
                    self.noPosts.isHidden = false
                }
            })
            
        }
    }
    
    func cancelOrder(){
        
        print(self.orderID!)
        
        self.startAnimating()
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.cancelOrder(orderID: self.orderID!, completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        print(response)
                        
                        let alertController = UIAlertController(title:"Order Canceled", message: "Order Canceled Sucessfully", preferredStyle:.alert)

                        let Action = UIAlertAction.init(title: "Ok", style: .default) { (UIAlertAction) in
                            
                            self.getOffers()
                        }

                        alertController.addAction(Action)
                        self.present(alertController, animated: true, completion: nil)
                        
                        UserDefault.deactivateOrder()
                        
                        self.stopAnimating()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.stopAnimating()
                    
                    Alert.show("Canceling Error", massege: "Please Try Again", context: self)
                    
                    self.stopAnimating()
                }
            })
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return offersList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OfferDetailsViewController") as! OfferDetailsViewController
        
        newViewController.offerID = String(offersList[indexPath.row].id)
        newViewController.orderID = String(offersList[indexPath.row].orderID)
        
        if let amountValue = offersList[indexPath.row].offerValue {
               
            let am = String(amountValue)
            newViewController.offerPriceStg = am
        }
        
        newViewController.starImgStg = offersList[indexPath.row].offerStar.imageID
        newViewController.offerTimeStg = convertDateFormater(offersList[indexPath.row].expectedDeliveryTime)
        
        newViewController.starNameStg = offersList[indexPath.row].offerStar.name
        newViewController.starHistoryStg = String(offersList[indexPath.row].offerStar.totalStarOrders.ordersCount) + " Orders Before"
        
        newViewController.starRateDbl = Double(offersList[indexPath.row].offerStar.totalStarOrders.overAllRate)
        
        newViewController.modalTransitionStyle = .flipHorizontal
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 128
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OffersTableViewCell") as! OffersTableViewCell
        
        cell.starImage.sd_setImage(with: URL(string: offersList[indexPath.row].offerStar.imageID), placeholderImage: UIImage(named: "017-Portrait-Photography-Manchester.png"))
        cell.starRating.rating = Double(offersList[indexPath.row].offerStar.totalStarOrders.overAllRate)
        cell.starName.text = offersList[indexPath.row].offerStar.name
        cell.starRating.rating = Double(offersList[indexPath.row].offerStar.totalStarOrders.overAllRate)
        
        if let amountValue = offersList[indexPath.row].offerValue {
               
            let am = String(amountValue)
            cell.offerPrice.text = am
        }
        
        //cell.offerPrice.text = String(offersList[indexPath.row].offerValue)
        
        cell.offerTime.text = convertDateFormater(offersList[indexPath.row].expectedDeliveryTime)
        
        return cell
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "hh:mm a"
        return  dateFormatter.string(from: date!)

    }
    
    
}
