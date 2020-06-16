//
//  MyOrdersViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MyOrdersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NVActivityIndicatorViewable {

    @IBOutlet weak var tableView: UITableView!
    
    var ordersList = Array<MyOrderElement>()
    
    @IBOutlet weak var noPosts: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getOrders()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 73.0
    }
    
    func getOrders(){
           
           self.startAnimating()
           noPosts.isHidden = true
           
           DispatchQueue.global(qos: .userInteractive).async {
               // Test Login request
               APIClient.getMyOrders(completion: { result in
                   switch result {
                   case .success(let response):
                       DispatchQueue.main.async {
                           print(response)
                           
                        if(response.orders.isEmpty)
                           {
                               self.tableView.isHidden = true
                               self.stopAnimating()
                               
                               self.noPosts.isHidden = false
                               
                           }else
                           {
                               for i in 0...response.orders.count - 1 {
                                   self.ordersList.append(response.orders[i])
                                
                               }
                               
                               self.tableView.reloadData()
                               self.tableView.isHidden = false
                               self.stopAnimating()
                           }
                           
                       }
                   case .failure(let error):
                       print(error.localizedDescription)
                       self.stopAnimating()
                       
                       self.tableView.isHidden = true
                       self.stopAnimating()
                       self.noPosts.isHidden = false
                   }
               })
               
           }
       }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ordersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrdersTableViewCell") as! MyOrdersTableViewCell
        
        cell.fromLabel.text = ordersList[indexPath.row].orderDetails
        cell.toLabel.text = ordersList[indexPath.row].orderFrom
        cell.orderDate.text = convertDateFormater(ordersList[indexPath.row].createdAt!)
        cell.orderRating.rating = 1
        
        return cell
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return  dateFormatter.string(from: date!)

    }
    

}
