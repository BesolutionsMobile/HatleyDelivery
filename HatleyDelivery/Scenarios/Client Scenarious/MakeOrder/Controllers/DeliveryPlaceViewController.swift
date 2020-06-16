//
//  DeliveryPlaceViewController.swift
//  HatleyOriginal
//
//  Created by Apple on 10/21/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class DeliveryPlaceViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tblPlaces: UITableView!
    @IBOutlet weak var tblLocations: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
      var orderPlace:String!
      var orderLat:Double!
      var orderLong:Double!
    
      let headerTitles = ["Location Search Results","Choose From Saved Places"]
      
      var resultsArray:[Dictionary<String, AnyObject>] = Array()
    
      var locationsArray = [RealmLocation]()
      
      var locationName:String?
      var locationLat:Double?
      var locationLong:Double?
      
    @IBOutlet weak var searchTableConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
              super.viewDidLoad()
              // Do any additional setup after loading the view, typically from a nib.
              txtSearch.addTarget(self, action: #selector(searchPlaceFromGoogle(_:)), for: .editingChanged)
              tblPlaces.estimatedRowHeight = 44.0
              tblPlaces.dataSource = self
              tblPlaces.delegate = self
          
        
        savedPlaces()
        
          }
    
    func savedPlaces()
    {
        
        let realm = try! Realm()
        let results = realm.objects(RealmLocation.self)
        
        if(results.isInvalidated || results.isEmpty)
        {
            locationsArray.removeAll()
            
        }else
        {
            if(results.count != 0)
            {
                locationsArray.removeAll()
                
                for i in stride(from: 0, through: results.count - 1, by: 1)
                {
                    locationsArray.append(results[i])
                    
                }
                
                
            }else
            {
                
            }
        }
        
        self.tblLocations.reloadData()
        
        
    
    }
    
    func calculateDistance(mobileLocationX:Double,mobileLocationY:Double,DestinationX:Double,DestinationY:Double) -> Double {
        
        let coordinate₀ = CLLocation(latitude: mobileLocationX, longitude: mobileLocationY)
        let coordinate₁ = CLLocation(latitude: DestinationX, longitude:  DestinationY)
        
        print(mobileLocationX)
        print(mobileLocationY)
        print(DestinationX)
        print(DestinationY)
        
        let distanceInMeters = coordinate₀.distance(from: coordinate₁)
        
        let distanceInKiloMeters = distanceInMeters / 1000
        
        print(round(distanceInKiloMeters))
        
        return round(distanceInKiloMeters)
    }
      
          //MARK:- UITableViewDataSource and UItableViewDelegates
          
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if(tableView == tblPlaces){
                return resultsArray.count
            }else{
                return locationsArray.count
            }
              
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            var cell:UITableViewCell
            
            if(tableView == tblPlaces){
               
                cell = tableView.dequeueReusableCell(withIdentifier: "placecell")!
                if let lblPlaceName = cell.contentView.viewWithTag(102) as? UILabel {
                    
                    let place = self.resultsArray[indexPath.row]
                    lblPlaceName.text = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
                }
                return cell
                
            }else{
                
                cell = tableView.dequeueReusableCell(withIdentifier: "SavedLocationTableViewCell")!
                
                if let lblPlaceName = cell.contentView.viewWithTag(103) as? UILabel {
                    
                    let place = self.locationsArray[indexPath.row]
                    lblPlaceName.text = place.locationName
            
                }
                
                
                
                
                return cell
                
                
            }
            
              
          }
          
          
          func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return UITableView.automaticDimension
          }
          
          func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if(tableView == tblPlaces){
                
                
                tableView.deselectRow(at: indexPath, animated: true)
                             let place = self.resultsArray[indexPath.row]
                             if let locationGeometry = place["geometry"] as? Dictionary<String, AnyObject> {
                                 if let location = locationGeometry["location"] as? Dictionary<String, AnyObject> {
                                     if let latitude = location["lat"] as? Double {
                                         if let longitude = location["lng"] as? Double {
                                             
                                             let newlocation = MKPointAnnotation()
                                             newlocation.title = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
                                             
                                             newlocation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                        
                                             self.locationName = "\(place["name"] as! String) \(place["formatted_address"] as! String)"
                                           
                                           self.locationLat = latitude
                                           self.locationLong = longitude
                                             
                                           let storyboard = UIStoryboard(name: "Main", bundle: nil)

                                           let vc = storyboard.instantiateViewController(withIdentifier: "FinalizeOrderViewController") as! FinalizeOrderViewController
                                           vc.orderPlace = orderPlace
                                           vc.deleviryPlace = locationName
                                           vc.orderPlaceLat = orderLat
                                           vc.orderPlaceLong = orderLong
                                           vc.deleviryPlaceLat = latitude
                                           vc.deleviryPlaceLong = longitude
                                           vc.distance = calculateDistance(mobileLocationX: latitude, mobileLocationY: longitude, DestinationX: orderLat, DestinationY: orderLong)
                                            
                                           
                                           self.navigationController?.pushViewController(vc, animated: true)
                                           
                                         }
                                     }
                                 }
                             }
                
            }else{
                
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)

                 let vc = storyboard.instantiateViewController(withIdentifier: "FinalizeOrderViewController") as! FinalizeOrderViewController
                   vc.orderPlace = orderPlace
                   vc.deleviryPlace = locationsArray[indexPath.row].locationName
                   vc.distance = calculateDistance(mobileLocationX: locationsArray[indexPath.row].locationLat!, mobileLocationY: locationsArray[indexPath.row].locationLong!, DestinationX: orderLat, DestinationY: orderLong)
                                                          
                self.navigationController?.pushViewController(vc, animated: true)
                
                
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

