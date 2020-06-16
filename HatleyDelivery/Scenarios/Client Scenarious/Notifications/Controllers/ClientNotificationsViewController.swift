//
//  ClientNotificationsViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/24/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ClientNotificationsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NVActivityIndicatorViewable {

    @IBOutlet weak var tableView: UITableView!
    
    var notificationsList = Array<NotificationItem>()
    
    @IBOutlet weak var noNotifications: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        noNotifications.isHidden = true
        self.tableView.tableFooterView = UIView()
        
    }
    
    func getNotifications(){
        
        self.startAnimating()
        
        notificationsList.removeAll()
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.getNotifications(completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        
                        print(response)
                        
                        if(response.notifications.count == 0)
                        {
                            self.tableView.isHidden = true
                            self.noNotifications.isHidden = false
                            self.stopAnimating()
                        }else
                        {
                            for i in 0...response.notifications.count - 1 {
                                self.notificationsList.append(response.notifications[i])
                            }
                            
                            self.tableView.reloadData()
                        }
                        
                        
                        self.stopAnimating()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                    self.tableView.isHidden = true
                    self.noNotifications.isHidden = false
                    self.stopAnimating()
                    
                }
            })
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90.0
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
        notificationsList.count
        
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientNotificationsTableViewCell") as! ClientNotificationsTableViewCell
               
        cell.notificationTitle.text = notificationsList[indexPath.row].title
        cell.notificationContent.text = notificationsList[indexPath.row].data
               
               return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(UserDefault.getType() == 1)
        {
            
        }else
        {
            if(notificationsList[indexPath.row].type == "accept_offer")
            {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let newViewController = storyBoard.instantiateViewController(withIdentifier: "ContinueChatViewController") as! ContinueChatViewController
                
                       newViewController.recivername = notificationsList[indexPath.row].sentFrom?.name
                
                       newViewController.clientPhoneNumber = notificationsList[indexPath.row].sentFrom?.phone
                
                newViewController.imageStg = notificationsList[indexPath.row].sentFrom?.imageID
                
                if let orderID = notificationsList[indexPath.row].orderID {
                   newViewController.orderID = String(orderID)
                }
                else{
                   newViewController.orderID = "41";
                }
                
                //newViewController.recivername = "amirahmed"
                newViewController.modalPresentationStyle = .fullScreen
                       
                self.present(newViewController, animated: true, completion: nil)
            }
            
        }
        
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNotifications()
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.09803921569, green: 0.4745098039, blue: 0.3215686275, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        
    }

}
