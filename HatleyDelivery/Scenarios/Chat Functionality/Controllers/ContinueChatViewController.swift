//
//  ContinoueChatViewController.swift
//  Firebase Chat Sample
//
//  Created by Apple on 10/1/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseUI

class ContinueChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sendMessageField: UITextField!
    
    @IBOutlet weak var seen: UILabel!
    
    var items = [ChatItem]()
    
    var orderID:String?
    
    var imageStg:String?
    
    var db:Firestore!
    
    var username:String?
    var recivername:String?
    var conversationname:String?
    
    var clientPhoneNumber:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.orderID!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFinish), name: .saveDateTime, object: nil)
        
         let nibNameLeft = UINib(nibName: "LeftTableViewCell", bundle: nil)
         tableView.register(nibNameLeft, forCellReuseIdentifier: "LeftTableViewCell")
               
         let nibNameRight = UINib(nibName: "RightTableViewCell", bundle: nil)
         tableView.register(nibNameRight, forCellReuseIdentifier: "RightTableViewCell")
        
        username = UserDefault.getName()
        
        conversationname = recivername! + "-" + username!
               
               
         tableView.separatorStyle = .none
               
         tableView.estimatedRowHeight = 138
         tableView.rowHeight = UITableView.automaticDimension
               
         db = Firestore.firestore()
               
         setUpRecyclerView()
        
         RealtimeSeen()
        
         gesture()
    }
    
    @objc func handleFinish(notification: Notification)
    {
        print(notification.userInfo ?? "")
        
        if let dict = notification.userInfo as NSDictionary? {
            if (dict["status"] as? String) != nil{
                
                if(dict["status"] as? String == "finish")
                {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "FeedbackPopUpViewController") as! FeedbackPopUpViewController
                    
                    newViewController.recivername = self.recivername
                    newViewController.starImgStg = self.imageStg
                    newViewController.orderID = self.orderID
                    
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

    }
    
    
    func gesture()
    {
        
        let left = UISwipeGestureRecognizer(target : self, action : #selector(NewChatViewController.rightSwipe))
        left.direction = .left
        self.view.addGestureRecognizer(left)
        
    }
    
    @objc
    func rightSwipe(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FinishOrderViewController") as! FinishOrderViewController
        
        newViewController.orderID = self.orderID
        newViewController.clientPhoneNumber = self.clientPhoneNumber
        
        
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    func setUpRecyclerView() {
        
    db.collection("Conversations").document(conversationname!).collection("Messages").order(by: "timeStamp", descending: false)
            .addSnapshotListener {
                querySnapshot, error in
                
                guard let snapshot = querySnapshot else {return}
                
                snapshot.documentChanges.forEach {
                    diff in
                    
                    if diff.type == .added {
                        self.items.append(ChatItem(dictionary: diff.document.data())!)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.tableView.scrollToBottom()
                        }
                    }
                }
        }
    }
    
    func sendMessage()
    {
        if(!sendMessageField.text!.isEmpty)
        {
        
        var seenArray = [String]()
        seenArray.append(username!)
               
        let newMessage = ChatItem(sender: username!, seenArray: seenArray, message: sendMessageField.text!, timeStamp: Date())
               
        var ref:DocumentReference? = nil
        
               ref = self.db.collection("Conversations").document(conversationname!).collection("Messages").addDocument(data: newMessage.dictionary) {
                   error in
                   
                   if let error = error {
                       print("Error adding document: \(error.localizedDescription)")
                   }else{
                    
                    self.updateChat(last: self.sendMessageField.text!)
                    
                       print("Document added with ID: \(ref!.documentID)")
                   }
                   
               }
               
               tableView.scrollToBottom()
            
            }
    }
    
    func updateChat(last:String)
    {
        let conversation = ["name" : username! + "-" + recivername!,
                     "sender" : username!,
                     "receiver" : recivername!,
                     "receiverImage" : "",
                     "lastMessage" : last,
                     "starFinish" : "No",
                     "timeStamp" : FieldValue.serverTimestamp()
            ] as [String : Any]

        self.db.collection("Conversations").document(self.conversationname!).setData(conversation)
    }
    
    
    func RealtimeSeen()
    {
        
      db.collection("Conversations").document(conversationname!).collection("Messages").order(by: "timeStamp", descending: true).limit(to: 1)
            .addSnapshotListener {
                querySnapshot, error in
                
                if (error != nil) {
                    print("Listen failed.")
                }
                
                if (querySnapshot != nil) {
                    
                    //List<String> group = (List<String>) snapshot.getDocuments().get(0).get("seenArray");
                    var group = [String]()
                    group = querySnapshot?.documents[0].get("seenArray") as! [String]
                    
                    if(group[0] != self.username)
                    {
                    
                        var seenArray = [String]()
                        seenArray.append(group[0])
                        seenArray.append(self.username!)
                        
                        let users = ["seenArray" : seenArray]
                        self.db.collection("Conversations").document(self.conversationname!).collection("Messages").document((querySnapshot?.documents[0].documentID)!).updateData(users)
                        
                    }
                    
                    if(group.count == 2)
                    {
                        self.seen.isHidden = false
                    }else
                        {
                            self.seen.isHidden = true
                        }
                    
                }else
                {
                    print("Current data: null")
                }
                
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let chat = items[indexPath.row]
        
        if(chat.sender==username)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightTableViewCell", for: indexPath) as? RightTableViewCell
            
            cell?.userName?.text = "\(chat.sender)"
            cell?.message?.text = "\(chat.message)"
            //cell?.time?.text = "\(chat.timeStamp)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "en_US")
            //cell?.time.text = dateFormatter.string(from: (chat.timeStamp))
            cell?.time.text = chat.timeStamp.timeAgoSinceDate()
            
            return cell!
        }else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftTableViewCell", for: indexPath) as? LeftTableViewCell
            
            cell?.userName?.text = "\(chat.sender)"
            cell?.message?.text = "\(chat.message)"
            //cell?.time?.text = "\(chat.timeStamp)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "en_US")
            //cell?.time.text = dateFormatter.string(from: (chat.timeStamp)) // Jan 2, 2001
            cell?.time.text = chat.timeStamp.timeAgoSinceDate()
            
            return cell!
        }
        
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = #colorLiteral(red: 0.09803921569, green: 0.4745098039, blue: 0.3215686275, alpha: 1)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
      
    }
    

    @IBAction func sendClick(_ sender: Any) {
        
        if(!sendMessageField.text!.isEmpty)
        {
            sendMessage()
            sendMessageField.text! = ""
        }
    }
    
}
