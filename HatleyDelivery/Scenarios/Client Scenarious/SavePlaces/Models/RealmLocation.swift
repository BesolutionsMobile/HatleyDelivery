//
//  RealmLocation.swift
//  HatleyOriginal
//
//  Created by Apple on 11/3/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import Foundation
import RealmSwift

class RealmLocation: Object {
    
    @objc dynamic var locationID = UUID().uuidString
    @objc dynamic var locationName:String!
    dynamic var locationLat:Double!
    dynamic var locationLong:Double!

}
