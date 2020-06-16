//
//  StarSettingsViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 11/6/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class StarSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NVActivityIndicatorViewable {

    
    @IBOutlet weak var tableView: UITableView!
    
    var items = [SettingItem]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.tableView.tableFooterView = UIView()

            
        }
    
    func fetchData()
    {
        items.append(SettingItem(itemName: "Personal Info", itemImage: "profile.png"))
        items.append(SettingItem(itemName: "Payments", itemImage: "money.png"))
        items.append(SettingItem(itemName: "Your Orders", itemImage: "list.png"))
        
        if(UserDefault.getType() == 1)
        {
            items.append(SettingItem(itemName: "Display Application as Star", itemImage: "wheel.png"))
        }else
        {
            items.append(SettingItem(itemName: "Display Application as Client", itemImage: "wheel.png"))
            
        }
        
        items.append(SettingItem(itemName: "Logout", itemImage: "logout.png"))
    }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60.0
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return items.count
            
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            switch indexPath.row {
            case 0:
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PersonalInfoViewController") as? PersonalInfoViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            case 1:
               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BalanceViewController") as? BalanceViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            case 2:
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyOrdersViewController") as? MyOrdersViewController
                self.navigationController?.pushViewController(vc!, animated: true)
               
            case 3:
                
                switchUser()
                
            case 4:
                
               logout()
                
            default:
                switchUser()
            }
            
        }
    
    
    func logout()
    {
        
        self.startAnimating()
    
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.logout(completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        
                       print(response)
                        
                       self.stopAnimating()
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                                              
                        newViewController.modalPresentationStyle = .fullScreen
                                              
                        self.present(newViewController, animated: true, completion: nil)
                        
                       UserDefault.setLogout()
                       UserDefault.disableFingerPrint()
                        
                       
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                    self.stopAnimating()
                }
            })
            
        }
        
        
    }
        
    func switchUser()
    {
            
            self.startAnimating()
        
            DispatchQueue.global(qos: .userInteractive).async {
                // Test Login request
                APIClient.switchUser(completion: { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            
                            print(response)
                            
                            self.stopAnimating()
                            
                            if(response.userTypeID == 1)
                            {
                                
                                UserDefault.setType(response.userTypeID)
                                
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainClientViewController") as! MainClientViewController
                                                           
                                newViewController.modalPresentationStyle = .fullScreen
                                                           
                                self.present(newViewController, animated: true, completion: nil)
                                
                            }else if(response.userTypeID == 2)
                            {
                                
                                UserDefault.setType(response.userTypeID)
                                
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainStarViewController") as! MainStarViewController
                                                           
                                newViewController.modalPresentationStyle = .fullScreen
                                                           
                                self.present(newViewController, animated: true, completion: nil)
                            }
                            
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        
                        self.stopAnimating()
                    }
                })
                
            }
            
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "StarSettingTableViewCell") as! StarSettingTableViewCell
            
            cell.listName.text = items[indexPath.row].itemName
            cell.listIcon.image = UIImage(named: items[indexPath.row].itemImage!)
            
            return cell
        }
        
        override func viewWillAppear(_ animated: Bool) {
               super.viewWillAppear(animated)
            
               fetchData()
               
               self.navigationController?.navigationBar.isHidden = false
               
               self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.09803921569, green: 0.4745098039, blue: 0.3215686275, alpha: 1)
               self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
               
               self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
               
               
           }

    }
