//
//  TypeItem.swift
//  HatleyOriginal
//
//  Created by Apple on 11/5/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

struct TypeItem:Decodable{
    
    var typeID:Int?
    var typeName:String?
     init(typeID:Int,typeName:String) {
        
        self.typeID = typeID
        self.typeName = typeName
    }
    
}

