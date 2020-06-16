//
//  FeedbackPopUpViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/24/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import Cosmos
import Firebase

class FeedbackPopUpViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var starName: UILabel!
    
    @IBOutlet weak var complainButton: UIButton!
    @IBOutlet weak var note1Button: UIButton!
    @IBOutlet weak var note2Button: UIButton!
    @IBOutlet weak var note3Button: UIButton!
    
    @IBOutlet weak var cont: UIStackView!
    
    var orderID:String?
    
    var starImgStg:String?
    
    var rate:Double?
    
    var username:String?
    var recivername:String?
    var conversationname:String?
    
    var db:Firestore!
    
    //--------------------
    
    @IBOutlet weak var overallconstraint: NSLayoutConstraint!
    
    @IBOutlet weak var complaintContainer: UIView!
    
    @IBOutlet weak var complaintTypeField: UITextField!
    @IBOutlet weak var messageField: UITextView!
    
    var types = Array<TypeItem>()
       
    var typesPickerView = UIPickerView()
    
    var typeID:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.orderID!)
        
        username = UserDefault.getName()
        
        conversationname = recivername! + "-" + username!

        starName.text = recivername
        
        titleLabel.text = "Evaluate Client"
        
        if(starImgStg==nil)
        {}else
        {
            starImage.sd_setImage(with: URL(string: starImgStg!), placeholderImage: UIImage(named: "017-Portrait-Photography-Manchester.png"))

        }
        
        db = Firestore.firestore()
        
        if (UserDefault.getType() == 2) {

            titleLabel.text = "Evaluate Star"

            updateChat()

        }
        
        designStuff()
        
        starRating.didFinishTouchingCosmos = { rating
            in
            
            print(rating)
            
            self.rate = rating
            
            if(rating < 2)
            {
                self.retrive(rating: rating)
            }else
            {
                self.rate(rating: rating, noteID: "")
            }
            
        }
        
        //------------
        
        getTypes()
        designStuffComplaint()
        
    }
    
    
    func designStuff()
    {
        
        overallconstraint.constant = 300.0
        
        complaintContainer.isHidden = true
        
        complainButton.layer.cornerRadius = 10
        note1Button.layer.cornerRadius = 10
        note2Button.layer.cornerRadius = 10
        note3Button.layer.cornerRadius = 10
        
        cont.isHidden = true
        complainButton.isEnabled = false
    }
    
    func retrive(rating:Double){
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.rate(orderID: self.orderID!, rate: String(rating), noteID: "", completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        
                        print(response)
                        
                        self.cont.isHidden = false
                        
                        self.complainButton.isEnabled = true
                        
                        self.note1Button.setTitle(response.notes[0].note, for: .normal)
                        
                        self.note2Button.setTitle(response.notes[1].note, for: .normal)
                        
                        self.note3Button.setTitle(response.notes[2].note, for: .normal)
    
                    }
                case .failure(let error):
                    print(error)
                    Alert.show("Error", massege: "Please Try Again", context: self)
                    
                }
            })
            
        }
    }
    
    func rate(rating:Double,noteID:String){
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.rate(orderID: self.orderID!, rate: String(rating), noteID: noteID, completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        print(response)
                    
                        self.dismiss(animated: true, completion: nil)
                        
                        let sentData:[String: String] = ["status": "complaint"]
                        
                        NotificationCenter.default.post(name: .saveDateTime, object: nil,userInfo: sentData)
    
                    }
                case .failure(let error):
                    print(error)
                    Alert.show("Error", massege: "Please Try Again", context: self)
                    
                }
            })
            
        }
    }
    
    
    @IBAction func complainButton(_ sender: Any) {
        
   //     let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
   //     let newViewController = storyBoard.instantiateViewController(withIdentifier: "MakeComplaintViewController") as! MakeComplaintViewController
                                                
   //     newViewController.orderID = self.orderID
        
   //     self.present(newViewController, animated: true, completion: nil)
        complaintContainer.isHidden = false
        self.overallconstraint.constant = 600.0
    }
    
    
    @IBAction func saveComplaint(_ sender: Any) {
        
        makeComplaint()
    }
    
    @IBAction func note1Cliked(_ sender: Any) {
        
        rate(rating: rate!, noteID: "1")
    }
    
    @IBAction func note2Clicked(_ sender: Any) {
        
        rate(rating: rate!, noteID: "2")
    }
    @IBAction func note3Clicked(_ sender: Any) {
        
        rate(rating: rate!, noteID: "3")
    }
    
    //-----------------------------------
    
    func designStuffComplaint()
    {
        
        complaintTypeField.inputView = typesPickerView
        
        typesPickerView.dataSource = self
        typesPickerView.delegate = self
        
        self.messageField.layer.borderWidth = 1.0
        self.messageField.layer.borderColor = #colorLiteral(red: 0.09803921569, green: 0.4745098039, blue: 0.3215686275, alpha: 1)
        self.messageField.layer.cornerRadius = 2.0
        self.messageField.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func makeComplaint()
    {
        
        let complaint = self.complaintTypeField.text
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            APIClient.makeComplaint(orderID: self.orderID!, complaint_type_id: String(self.typeID!), complaint: complaint!, completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        
                        print(response)
                        
                        let alert = UIAlertController(title: "Make Complaint", message: "Complaint Submitted Successfully", preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
                            
                            self.dismiss(animated: true, completion: nil)
                            
                            let sentData:[String: String] = ["status": "complaint"]
                            
                            NotificationCenter.default.post(name: .saveDateTime, object: nil,userInfo: sentData)
                        }))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            })
            
        }
    }

    
    
    func getTypes()
    {
        DispatchQueue.global(qos: .userInteractive).async {
            
            APIClient.getComplaintTypes(completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        
                        print(response)
                        
                        self.types.removeAll()
                        for i in 0...response.compliantTypes.count - 1 {
                            
                            self.types.append(TypeItem(typeID: response.compliantTypes[i].id, typeName: response.compliantTypes[i].type))
                    
                        }
                    
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            })
            
        }
    }
    
    
    func updateChat()
    {
        let conversation = ["name" : conversationname!,
                     "sender" : username!,
                     "receiver" : recivername!,
                     "receiverImage" : "",
                     "lastMessage" : "last",
                     "starFinish" : "Yes",
                     "timeStamp" : FieldValue.serverTimestamp()
            ] as [String : Any]

        self.db.collection("Conversations").document(self.conversationname!).setData(conversation)
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return types[row].typeName
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.complaintTypeField.text = types[row].typeName
        typeID = types[row].typeID
    }
}
