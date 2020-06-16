//
//  MakeComplaintViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit

class MakeComplaintViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    

    @IBOutlet weak var complaintTypeField: UITextField!
    @IBOutlet weak var messageField: UITextView!
    
    var types = Array<TypeItem>()
    
    var typesPickerView = UIPickerView()
    
    var orderID:String?
    var typeID:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getTypes()
        designStuff()
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
                            
                            //self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
                            
                            self.dismiss(animated: true, completion: nil)
                            
                            NotificationCenter.default.post(name: .saveDateTime, object: self)
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

    func designStuff()
    {
        
        complaintTypeField.inputView = typesPickerView
        
        typesPickerView.dataSource = self
        typesPickerView.delegate = self
        
        self.messageField.layer.borderWidth = 1.0
        self.messageField.layer.borderColor = #colorLiteral(red: 0.09803921569, green: 0.4745098039, blue: 0.3215686275, alpha: 1)
        self.messageField.layer.cornerRadius = 2.0
        self.messageField.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    @IBAction func saveClicked(_ sender: Any) {
        
        makeComplaint()
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


