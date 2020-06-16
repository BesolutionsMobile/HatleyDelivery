//
//  NewChatViewController.swift
//  Firebase Chat Sample
//
//  Created by Apple on 10/1/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import FirebaseUI

class NewChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sendMessageField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var seen: UILabel!
    
    var orderID:String?
    
    var imageStg:String?
    
    var items = [ChatItem]()
    
    var db:Firestore!
    
    var username:String?
    var recivername:String?
    
    var conversationname:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleFinish), name: .saveDateTime, object: nil)
        
        let nibNameLeft = UINib(nibName: "LeftTableViewCell", bundle: nil)
                tableView.register(nibNameLeft, forCellReuseIdentifier: "LeftTableViewCell")
                      
        let nibNameRight = UINib(nibName: "RightTableViewCell", bundle: nil)
                tableView.register(nibNameRight, forCellReuseIdentifier: "RightTableViewCell")
        
        db = Firestore.firestore()
        
        username = UserDefault.getName()
        //recivername = "amir"
        
        conversationname = username! + "-" + recivername!
        
        tableView.separatorStyle = .none
              
        tableView.estimatedRowHeight = 138
        tableView.rowHeight = UITableView.automaticDimension
        
        setUpRecyclerView()
        
       // hideChat()
        addChat()
        
        gesture()

    }
    
    @objc func handleFinish(notification: Notification)
    {
        print("here")
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainClientViewController") as! MainClientViewController
        
        newViewController.modalPresentationStyle = .fullScreen
        
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    
    func gesture()
    {
        
      //  let right = UISwipeGestureRecognizer(target : self, action : #selector(NewChatViewController.rightSwipe))
      //  right.direction = .right
       // self.tableView.addGestureRecognizer(right)
        
    }
    
    @objc
    func rightSwipe(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FeedbackPopUpViewController") as! FeedbackPopUpViewController
        
        newViewController.orderID = orderID
        newViewController.starImgStg = imageStg
        
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    func hideChat()
    {
        self.sendMessageField.isHidden = true
        self.tableView.isHidden = true
        self.sendButton.isHidden = true
        seen.isHidden = true
    }
    
    @IBAction func sendClick(_ sender: Any) {
        
        if(!sendMessageField.text!.isEmpty)
        {
           sendMessage()
        }
    }
    
    func addChat()
    {
       
        let conversation = ["name" : conversationname!,
                 "sender" : username!,
                 "receiver" : recivername!,
                 "receiverImage" : "",
                 "lastMessage" : "Hello " + self.recivername! + " are you Here..?",
                 "starFinish" : "No",
                 "timeStamp" : FieldValue.serverTimestamp()
        ] as [String : Any]
        
        self.db.collection("Conversations").document(conversationname!).setData(conversation) {
            error in
            
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            }else{
             
                self.sendMessageIntial(message: "Hello " + self.recivername! + " are you Here..")
             
                print("Document added")
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
    
    func sendMessageIntial(message:String)
    {
        
        var seenArray = [String]()
        seenArray.append(username!)
               
        let newMessage = ChatItem(sender: username!, seenArray: seenArray, message: message, timeStamp: Date())
               
        var ref:DocumentReference? = nil
        
               ref = self.db.collection("Conversations").document(conversationname!).collection("Messages").addDocument(data: newMessage.dictionary) {
                   error in
                   
                   if let error = error {
                       print("Error adding document: \(error.localizedDescription)")
                   }else{
                    
                    self.updateChat(last: message)
                    self.RealtimeSeen()
                    self.RealtimeRate()
                    
                    print("Document added with ID: \(ref!.documentID)")
                   }
                   
               }
               
               tableView.scrollToBottom()
         
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
    
    func RealtimeRate()
    {
      db.collection("Conversations").document(conversationname!).addSnapshotListener {
        
                querySnapshot, error in
                
                if (error != nil) {
                    print("Listen failed.")
                }
                
                if (querySnapshot != nil) {
                    
                    var ddg:String
                    ddg = querySnapshot?.get("starFinish") as! String
                    
                    if(ddg == "Yes")
                    {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "FeedbackPopUpViewController") as! FeedbackPopUpViewController
                        
                        newViewController.recivername = self.recivername
                        newViewController.orderID = self.orderID
                        
                        self.present(newViewController, animated: true, completion: nil)
                    }
                    
                }else
                {
                    print("Current data: null")
                }
                
        }
        
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
    
    
    func setUpRecyclerView() {
        
        db.collection("Conversations").document(username! + "-" + recivername!).collection("Messages").order(by: "timeStamp", descending: false)
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
            cell?.time.text = dateFormatter.string(from: (chat.timeStamp)) // Jan 2, 2001
            
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
            cell?.time.text = dateFormatter.string(from: (chat.timeStamp)) // Jan 2, 2001
            
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
       
    
}


extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if (rows > 0){
            self.scrollToRow(at: NSIndexPath(row: rows - 1, section: sections - 1) as IndexPath, at: .bottom, animated: true)
        }
    }
}

