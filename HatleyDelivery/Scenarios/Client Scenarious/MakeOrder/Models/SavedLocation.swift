//
//  SavedLocation.swift
//  HatleyOriginal
//
//  Created by Apple on 11/3/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import Foundation

struct SavedLocation:Decodable{
    
    var locationName:String?
    var locationLatitude:Double?
    var locationLongtiude:Double?
     init(locationName:String,locationLatitude:Double,locationLongtiude:Double) {
        
        self.locationName = locationName
        self.locationLatitude = locationLatitude
        self.locationLongtiude = locationLongtiude
    }
    
}
