//
//  OrderPlaceViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/21/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import MapKit

class OrderPlaceViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var confirmLocation: UIButton!
    @IBOutlet weak var tblPlaces: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var map: MKMapView!
    
    var resultsArray:[Dictionary<String, AnyObject>] = Array()
    
    var locationName:String?
    var locationLat:Double?
    var locationLong:Double?
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            txtSearch.addTarget(self, action: #selector(searchPlaceFromGoogle(_:)), for: .editingChanged)
            tblPlaces.estimatedRowHeight = 44.0
            tblPlaces.dataSource = self
            tblPlaces.delegate = self
        
            confirmLocation.isHidden = true
        
        tblPlaces.isHidden = true
        
        }
    
    @IBAction func confirmClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: "DeliveryPlaceViewController") as! DeliveryPlaceViewController 
        vc.orderPlace = locationName
        vc.orderLat = locationLat
        vc.orderLong = locationLong
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
        //MARK:- UITableViewDataSource and UItableViewDelegates
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return resultsArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "placecell")
            if let lblPlaceName = cell?.contentView.viewWithTag(102) as? UILabel {
                
                if(indexPath.row == 0)
                {
                    print("error")
                }else
                {
                    let place = try self.resultsArray[indexPath.row]
                    lblPlaceName.text = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
                }
              
                
            }
            return cell!
        }
        
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let place = self.resultsArray[indexPath.row]
            if let locationGeometry = place["geometry"] as? Dictionary<String, AnyObject> {
                if let location = locationGeometry["location"] as? Dictionary<String, AnyObject> {
                    if let latitude = location["lat"] as? Double {
                        if let longitude = location["lng"] as? Double {
                            
                            let newlocation = MKPointAnnotation()
                            newlocation.title = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
                            
                            newlocation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                            
                            self.map.addAnnotation(newlocation)
                            
                            self.confirmLocation.isHidden = false
                            
                            self.tblPlaces.isHidden = true
                            
                            self.resultsArray.removeAll()
                            
                            self.locationName = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
                            
                            self.locationLat = latitude
                            self.locationLong = longitude
                            
                        }
                    }
                }
            }
        }

        
        
       @objc func searchPlaceFromGoogle(_ textField:UITextField) {
        
        if let searchQuery = textField.text {
            var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchQuery)&key= AIzaSyAFZWqZ7it3SPq_vuGpWM7qPx1ZrLAYB74"
            strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
            urlRequest.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, resopnse, error) in
                if error == nil {
                    
                    if let responseData = data {
                    let jsonDict = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        
                        if let dict = jsonDict as? Dictionary<String, AnyObject>{
                            
                            if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                                print("json == \(results)")
                                self.resultsArray.removeAll()
                                for dct in results {
                                    self.resultsArray.append(dct)
                                }
                                
                                DispatchQueue.main.async {
                                 self.tblPlaces.reloadData()
                                    
                                 self.tblPlaces.isHidden = false
                                }
                                
                            }
                        }
                       
                    }
                } else {
                    //we have error connection google api
                }
            }
            task.resume()
        }
  }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }


    }

