//
//  SettingItem.swift
//  HatleyOriginal
//
//  Created by Apple on 11/4/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

struct SettingItem:Decodable{
    
    var itemName:String?
    var itemImage:String?
     init(itemName:String,itemImage:String) {
        
        self.itemName = itemName
        self.itemImage = itemImage
    }
    
}

