//
//  MakeOfferViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/22/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import Cosmos
import MapKit

class MakeOfferViewController: UIViewController {

    @IBOutlet weak var offerClientName: UILabel!
    @IBOutlet weak var offerClientRate: CosmosView!
    @IBOutlet weak var offerClientHistory: UILabel!
    @IBOutlet weak var offerFrom: UILabel!
    @IBOutlet weak var offerTo: UILabel!
    
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var myOfferArrivalTime: UITextField!
    @IBOutlet weak var myOfferPrice: UITextField!
    
    @IBOutlet weak var createOfferButton: UIButton!
    
    var offerClientNameStg:String?
    var offerClientRateDbl:Double?
    var offerClientHistoryStg:String?
    var offerFromStg:String?
    var offerToStg:String?
    
    var offerFromLat:Double?
    var offerFromLong:Double?
    
    var offerToLat:Double?
    var offerToLong:Double?
    
    var myOfferArrivalTimeStg:String?
    var myOfferPriceStg:String?
    
    var starID:String?
    var orderID:String?
    
    let datePicker = UIDatePicker()
    
    var arrivaltimetext:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        offerClientName.text = offerClientNameStg
        offerClientHistory.text = offerClientHistoryStg
        offerFrom.text = offerFromStg
        offerTo.text = offerToStg
        
        offerClientRate.rating = offerClientRateDbl!
        
        mapStuff()
        designStuff()
        
        starID = String(UserDefault.getID())
        
        
        showDatePicker()
        
    }
    
    func designStuff()
    {
        createOfferButton.layer.cornerRadius = 15
    }
    
    func mapStuff()
    {
        
        let orderLocation = MKPointAnnotation()
        
        orderLocation.coordinate = CLLocationCoordinate2D(latitude: offerFromLat!, longitude: offerFromLong!)
        
        self.map.addAnnotation(orderLocation)
        
        let clientLocation = MKPointAnnotation()
        
        clientLocation.coordinate = CLLocationCoordinate2D(latitude: offerToLat!, longitude: offerToLong!)
        
        self.map.addAnnotation(clientLocation)
        
    }
    
    
    func offeringProcess(){
        
        print(self.orderID!)
        print(self.starID!)
        
        //let arrivaltime = "2019-12-26 10:59:34"
        let arrivaltime = arrivaltimetext!
        let price = myOfferPrice.text
        
        DispatchQueue.global(qos: .userInteractive).async {
            // Test Login request
            APIClient.submitOffer(starID: self.starID!, orderID: self.orderID!, expected_delivery_time: arrivaltime, offer_value: price!, mobile_token: UserDefault.getToken(), completion: { result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        print(response)
                                                
                        //Alert.show("Congrates", massege: "Offer Submitted Successfully", context: self)
                        self.alert(title: "Congrates", body: "Offer Submitted Successfully")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            })
            
        }
    }
    
    
    func alert(title:String,body:String)
    {
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            self.dismiss(animated: true, completion: nil)
            
            NotificationCenter.default.post(name: .saveDateTime, object: nil)
        }

        // Add the actions
        alertController.addAction(okAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .time
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        myOfferArrivalTime.inputAccessoryView = toolbar
        myOfferArrivalTime.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd hh:mm:ss"
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "hh:mm"
        
        myOfferArrivalTime.text = formatter2.string(from: datePicker.date)
        
        arrivaltimetext = formatter.string(from: datePicker.date)
        
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    @IBAction func createOffer(_ sender: Any) {
        
        offeringProcess()
        
        print(arrivaltimetext!)
    }
    @IBAction func closeClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "HH:mm"
        return  dateFormatter.string(from: date!)

    }
    
    
}
