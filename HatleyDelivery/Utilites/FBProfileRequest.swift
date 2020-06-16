//
//  Facebook.swift
//  Eschoola
//
//  Created by Admin on 6/7/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import Foundation
import FacebookCore


struct FBProfileRequest: GraphRequestProtocol {
    
   struct Response: GraphResponseProtocol, Codable {
    
      let name: String?
      let email: String?
      let facebookId: String?
      let picUrl: String?
      init(rawResponse: Any?) {
         // Decode JSON from rawResponse into other properties here.
         let dict = rawResponse as? [String: Any]
         name = dict?["name"] as? String
         email = dict?["email"] as? String
         facebookId = dict?["id"] as? String
         let imageDict = (dict?["picture"] as? [String: Any])?["data"] as? [String: Any]
         picUrl =  imageDict?["is_silhouette"] as? Int == 0 ? (imageDict?["url"] as? String) : ""
      }
   }
   
   var graphPath = "/me"
   // swiftlint:disable discouraged_optional_collection
   var parameters: [String: Any]? = ["fields": "id, name, email, picture"]
   // swiftlint:enable discouraged_optional_collection
   var accessToken = AccessToken.current
   var httpMethod: GraphRequestHTTPMethod = .GET
   var apiVersion: GraphAPIVersion = .defaultVersion
}
