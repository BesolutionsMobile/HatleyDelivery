//
//  Constants.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 26/11/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {

        static let baseURL = "https://www.hatly.be4maps.com/api"
    }
    
    struct Login {
        static let email = "email"
        static let password = "password"
        static let mobile_token = "mobile_token"
    }
    
    struct Registration {
        static let name = "name"
        static let email = "email"
        static let password = "password"
        static let password_confirmation = "password_confirmation"
        static let mobile_token = "mobile_token"
        static let image_id = "image_id"
    }
    
    struct ShowOrders {
        static let starLat = "starLat"
        static let starLong = "starLong"
        static let mobile_token = "mobile_token"
    }
    
    struct PublishOrder {
        static let order_description = "order_description"
        static let image = "image"
        static let distance = "distance"
        static let duration = "duration"
        static let promo_code = "promo_code"
        static let delivery_time = "delivery_time"
        static let order_from_location = "order_from_location"
        static let order_to_location = "order_to_location"
        static let client_location_lat = "client_location_lat"
        static let client_location_long = "client_location_long"
        static let order_location_lat = "order_location_lat"
        static let order_location_long = "order_location_long"
        static let mobile_token = "mobile_token"
    }
    
    struct AcceptRejectOffer {
        static let offer_id = "offer_id"
        static let mobile_token = "mobile_token"
    }
    
    struct SubmitOffer {
        static let star_id = "star_id"
        static let order_id = "order_id"
        static let expected_delivery_time = "expected_delivery_time"
        static let offer_value = "offer_value"
        static let mobile_token = "mobile_token"
    }
    
    struct Rate {
        static let order_id = "order_id"
        static let rate = "rate"
        static let note_id = "note_id"
    }
    
    struct Complaint {
        static let order_id = "order_id"
        static let complaint_type_id = "complaint_type_id"
        static let complaint = "complaint"
    }
    
    struct FinishOrder{
        static let order_id = "order_id"
        static let bill_amount = "bill_amount"
        static let mobile_token = "mobile_token"
    }
    
    struct CancelOrder{
        static let order_id = "order_id"
    }
    
    struct PromoCode{
        static let promo_code = "promo_code"
    }
    
    struct PhoneNumber{
        static let phone = "phone"
    }
    
    struct ChangePassword{
        static let password = "password"
        static let password_confirmation = "password_confirmation"
    }
    
    struct ChangePhoto{
        static let image_url = "image_url"
    }
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
