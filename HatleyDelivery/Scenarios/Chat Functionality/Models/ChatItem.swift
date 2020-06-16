//
//  ChatItem.swift
//  Firebase Chat Sample
//
//  Created by Apple on 12/13/18.
//  Copyright © 2018 amirahmed. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}

struct ChatItem{
    
    var sender:String
    var seenArray:[String]
    var message:String
    var timeStamp:Date
    
    
    var dictionary:[String:Any]{
        return [
            "sender":sender,
            "seenArray":seenArray,
            "message":message,
            "timeStamp":timeStamp
        ]
    }
}

extension ChatItem : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let sender = dictionary["sender"] as? String,
            let seenArray = dictionary["seenArray"] as? [String],
            let message = dictionary["message"] as? String,
            let timeStamp = dictionary ["timeStamp"] as? Timestamp else {return nil}
        
      
        let date: Date = timeStamp.dateValue()
        
        self.init(sender: sender,seenArray: seenArray, message: message, timeStamp: date)
    }
}
