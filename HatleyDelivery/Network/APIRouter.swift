//
//  APIRouter.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 26/11/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case login(email:String, password:String, mobile_token:String)
    case user_details
    case registration(name:String, email:String, password:String, confirm:String,mobile_token:String,image_id:String)
    case logout
    case publish_order(order_description:String,image:String,distance:String,duration:String,promo_code:String,delivery_time:String,order_from_location:String,order_to_location:String,client_location_lat:String,client_location_long:String,order_location_lat:String,order_location_long:String,mobile_token:String)
    
    case getOffers
    case acceptOffer(offerID:String,mobile_token:String)
    case rejectOffer(offerID:String)
    case submitOffer(starID:String,orderID:String,expected_delivery_time:String,offer_value:String,mobile_token:String)
    
    case getOrders(starLat:String,starLong:String,mobile_token:String)
    case getNotifications
    case rate(orderID:String,rate:String,noteID:String)
    case finishOrder(orderID:String,billAmount:String,mobile_token:String)
    case cancelOrder(orderID:String)
    case promoCode(promo_code:String)
    case balance
    case myOrders
    case complaintTypes
    case makeComplaint(orderID:String, complaint_type_id:String, complaint:String)
    case addPhoto(image_url:String)
    case changePassword(password:String, password_confirmation:String)
    case changePhone(phone:String)
    case switchUser
    
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .user_details:
            return .get
        case .registration:
            return .post
        case .logout:
            return .get
        case .publish_order:
            return .post
        case .getOffers:
            return .get
        case .acceptOffer:
            return .post
        case .rejectOffer:
            return .post
        case .getOrders:
            return .post
        case .submitOffer:
            return .post
        case .getNotifications:
            return .get
        case .rate:
            return .post
        case .finishOrder:
            return .patch
        case .cancelOrder:
            return .patch
        case .promoCode:
            return .post
        case .balance:
            return .get
        case .myOrders:
            return .get
        case .complaintTypes:
            return .get
        case .makeComplaint:
            return .post
        case .addPhoto:
            return .patch
        case .changePassword:
            return .patch
        case .changePhone:
            return .patch
        case .switchUser:
            return .patch
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .user_details:
            return "/user-details"
        case .registration:
            return "/auth/register"
        case .logout:
            return "/logout"
        case .publish_order:
            return "/store-order"
        case .getOffers:
            return "/order-offers/" + UserDefault.getorderID()
            //return "/order-offers/505"
        case .acceptOffer:
            return "/accept-offer"
        case .rejectOffer:
            return "/reject-offer"
        case .getOrders:
            return "/show-orders"
        case .submitOffer:
            return "/submit-offer"
        case .getNotifications:
            return "/my-notifications"
        case .rate:
            return "/rate"
        case .finishOrder:
            return "/finish-order"
        case .cancelOrder:
            return "/cancel-order"
        case .promoCode:
            return "/add-promocode"
        case .balance:
            return "/get-balance"
        case .myOrders:
            return "/my-orders"
        case .complaintTypes:
            return "/get-complaint-type"
        case .makeComplaint:
            return "/make-complaint"
        case .addPhoto:
             return "/update-personal-image"
        case .changePassword:
             return "/make-complaint"
        case .changePhone:
             return "/add-phone"
        case .switchUser:
            return "/switch-user"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password, let mobile_token):
            return [K.Login.email: email, K.Login.password: password, K.Login.mobile_token: mobile_token]
        case .user_details:
            return nil
        case .registration(let name, let email, let password, let confirm,let mobile_token,let image_id):
            return [K.Registration.name: name, K.Registration.email: email, K.Registration.password: password, K.Registration.password_confirmation: confirm,
                    K.Registration.mobile_token: mobile_token,K.Registration.image_id: image_id]
        case .logout:
            return nil
        
        case .publish_order(let order_description, let image, let distance, let duration, let promo_code, let delivery_time, let order_from_location, let order_to_location, let client_location_lat, let client_location_long, let order_location_lat, let order_location_long, let mobile_token):
            return [K.PublishOrder.order_description: order_description,K.PublishOrder.image: image,K.PublishOrder.distance: distance,K.PublishOrder.duration: duration,K.PublishOrder.promo_code: promo_code,K.PublishOrder.delivery_time: delivery_time,K.PublishOrder.order_from_location: order_from_location,K.PublishOrder.order_to_location: order_to_location,K.PublishOrder.client_location_lat: client_location_lat,K.PublishOrder.client_location_long: client_location_long, K.PublishOrder.order_location_lat: order_location_lat, K.PublishOrder.order_location_long: order_location_long, K.PublishOrder.mobile_token: mobile_token]
        case .getOffers:
            return nil
        case .acceptOffer(let offerID,let mobileToken):
            return[K.AcceptRejectOffer.offer_id: offerID,K.AcceptRejectOffer.mobile_token: mobileToken]
        case .rejectOffer(let offerID):
            return[K.AcceptRejectOffer.offer_id: offerID]
        case .getOrders(let starLat, let starLong, let mobile_token):
            return [K.ShowOrders.starLat: starLat,K.ShowOrders.starLong: starLong,K.ShowOrders.mobile_token: mobile_token]
        case .submitOffer(let starID, let orderID, let expected_delivery_time, let offer_value, let mobile_token):
            return [K.SubmitOffer.star_id: starID,K.SubmitOffer.order_id: orderID,K.SubmitOffer.expected_delivery_time: expected_delivery_time,K.SubmitOffer.offer_value: offer_value,K.SubmitOffer.mobile_token: mobile_token]
        case .getNotifications:
            return nil
        case .rate(let orderID, let rate, let noteID):
            return [K.Rate.order_id: orderID,K.Rate.rate: rate,K.Rate.note_id: noteID]
        case .finishOrder(let orderID, let billAmount, let mobile_token):
            return [K.FinishOrder.order_id: orderID,K.FinishOrder.bill_amount: billAmount, K.FinishOrder.mobile_token: mobile_token]
        case .cancelOrder(let orderID):
            return [K.CancelOrder.order_id: orderID]
        case .promoCode(let promo_code):
            return [K.PromoCode.promo_code: promo_code]
        case .balance:
            return nil
        case .myOrders:
            return nil
        case .complaintTypes:
            return nil
        case .makeComplaint(let orderID, let complaint_type_id, let complaint):
            return [K.Complaint.order_id: orderID, K.Complaint.complaint_type_id: complaint_type_id, K.Complaint.complaint: complaint]
        case .addPhoto(let image_url):
            return [K.ChangePhoto.image_url: image_url]
        case .changePassword(let password, let password_confirmation):
            return [K.ChangePassword.password: password, K.ChangePassword.password_confirmation: password_confirmation]
        case .changePhone(let phone):
            return [K.PhoneNumber.phone: phone]
        case .switchUser:
            return nil
        }
}
    
// MARK: - URLRequestConvertible
func asURLRequest() throws -> URLRequest {
    
    let url = try K.ProductionServer.baseURL.asURL()
    
    var urlRequest = URLRequest(url: url.appendingPathComponent(path))
    
    // HTTP Method
    urlRequest.httpMethod = method.rawValue
    
    // Common Headers
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
    urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
    urlRequest.setValue("Bearer " + UserDefault.getToken(), forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
    
    
    // Parameters
    var encodedURLRequest:URLRequest? = nil
    
    var Vparameters: [String: Any]
    
    if(parameters == nil)
    {
        encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: nil)
    }else
    {
        Vparameters = parameters!
        encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: Vparameters)
    }

    
    return encodedURLRequest!
    
    }
}

