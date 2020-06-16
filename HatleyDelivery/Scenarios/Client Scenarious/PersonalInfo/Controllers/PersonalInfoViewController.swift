//
//  PersonalInfoViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit

class PersonalInfoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var itemsList = Array<SettingItem>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fill()
    }
    
    func fill()
    {
        
        self.tableView.tableFooterView = UIView()
        
        itemsList.append(SettingItem(itemName: UserDefault.getName(), itemImage: "username.png"))
        itemsList.append(SettingItem(itemName: UserDefault.getEmail(), itemImage: "email.png"))
        itemsList.append(SettingItem(itemName: "Change Your Password", itemImage: "password.png"))
        itemsList.append(SettingItem(itemName: "Add your Phone", itemImage: "addphone.png"))
        itemsList.append(SettingItem(itemName: "Append Your National ID", itemImage: "id.png"))
        itemsList.append(SettingItem(itemName: "Add Your Photo", itemImage: "photo.png"))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalInfoTableViewCell") as! PersonalInfoTableViewCell
        
        cell.itemName.text = itemsList[indexPath.row].itemName
        cell.itemImage.image = UIImage(named: itemsList[indexPath.row].itemImage!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 2)
        {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
            
            newViewController.modalPresentationStyle = .fullScreen
            
            self.present(newViewController, animated: true, completion: nil)
            
            
        }else if(indexPath.row == 3)
        {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ChangePhoneViewController") as! ChangePhoneViewController
            
            newViewController.modalPresentationStyle = .fullScreen
            
            self.present(newViewController, animated: true, completion: nil)
            
        }else if(indexPath.row == 5)
        {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AddPhotoViewController") as! AddPhotoViewController
            
            newViewController.modalPresentationStyle = .fullScreen
            
            self.present(newViewController, animated: true, completion: nil)
    
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.09803921569, green: 0.4745098039, blue: 0.3215686275, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        
    }


}
