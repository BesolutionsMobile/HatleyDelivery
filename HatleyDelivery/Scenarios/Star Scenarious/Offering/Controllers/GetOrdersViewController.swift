//
//  GetOrdersViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/22/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class GetOrdersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NVActivityIndicatorViewable {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noOrders: UILabel!
    
    var ordersList = Array<Orderr>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        
        noOrders.isHidden = true
        
         NotificationCenter.default.addObserver(self, selector: #selector(handleFinish), name: .saveDateTime, object: nil)
    }
    
    @objc func handleFinish(notification: Notification)
    {
        self.noOrders.isHidden = true
        
        getOrders()
    }

    
    func getOrders(){
        
        self.startAnimating()
        
        ordersList.removeAll()
        
        self.tableView.reloadData()
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.getOrders(starLat: "30.008133", starLong: "31.185710", mobile_token: UserDefault.getToken(), completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        
                        print(response)
                        
                        if(response.orders.isEmpty)
                        {
                            self.noOrders.isHidden = false
                        }else
                        {
                            for i in 0...response.orders.count - 1 {
                            self.ordersList.append(response.orders[i])
                        }
                                                       
                            self.tableView.reloadData()
                        }
                        
                        self.stopAnimating()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                    self.noOrders.isHidden = false
                    self.stopAnimating()
                }
            })
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ordersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GetOrdersTableViewCell") as! GetOrdersTableViewCell
        
       // let str = "abcdef"
       // str[0 ..< 2] // returns "ab"
        
        if let amountValue = ordersList[indexPath.row].orderFinance.minimumValue {
               
            let am = String(amountValue)[0 ..< 2]
            cell.orderExpectedPrice.text = am
        }
        cell.orderTitle.text = ordersList[indexPath.row].orderDetails.orderDetails
        cell.orderFrom.text = ordersList[indexPath.row].orderDetails.orderFrom
        cell.orderTo.text = ordersList[indexPath.row].orderDetails.orderTo
        cell.orderClientName.text = ordersList[indexPath.row].orderDetails.orderClient.name
        cell.orderClientRate.rating = Double(ordersList[indexPath.row].orderDetails.orderClient.totalUserOrders.overAllRate)
        cell.orderExpectedTime.text = convertDateFormater(ordersList[indexPath.row].deliveryTime!)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: "MakeOfferViewController") as! MakeOfferViewController
               
        newViewController.orderID = String(ordersList[indexPath.row].id)
               
        newViewController.offerClientNameStg = ordersList[indexPath.row].orderDetails.orderClient.name
        
        newViewController.offerClientRateDbl = Double(ordersList[indexPath.row].orderDetails.orderClient.totalUserOrders.overAllRate)
               
        newViewController.offerClientHistoryStg = String(ordersList[indexPath.row].orderDetails.orderClient.totalUserOrders.ordersCount) + " Orders Before"
        
        newViewController.offerFromStg = ordersList[indexPath.row].orderDetails.orderFrom
        newViewController.offerToStg = ordersList[indexPath.row].orderDetails.orderTo
        
        newViewController.offerToLat = ordersList[indexPath.row].orderDetails.clientLocationLat
        newViewController.offerToLong = ordersList[indexPath.row].orderDetails.clientLocationLong
        
        newViewController.offerFromLat = ordersList[indexPath.row].orderDetails.orderLocationLat
        newViewController.offerFromLong = ordersList[indexPath.row].orderDetails.orderLocationLong
        
        newViewController.modalTransitionStyle = .flipHorizontal
               
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm"
        return  dateFormatter.string(from: date!)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.noOrders.isHidden = true
        
        getOrders()
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.09803921569, green: 0.4745098039, blue: 0.3215686275, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        
    }

}


extension String {

  var length: Int {
    return count
  }

  subscript (i: Int) -> String {
    return self[i ..< i + 1]
  }

  func substring(fromIndex: Int) -> String {
    return self[min(fromIndex, length) ..< length]
  }

  func substring(toIndex: Int) -> String {
    return self[0 ..< max(0, toIndex)]
  }

  subscript (r: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                        upper: min(length, max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }

}
