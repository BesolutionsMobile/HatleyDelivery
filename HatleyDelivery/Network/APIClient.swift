//
//  APIClient.swift/Users/apple/Documents/Xcode/HatleyOriginal/HatleyOriginal/Network/Constants.swift
//  Networking
//
//  Created by Alaeddine Messaoudi on 14/12/2017.
//  Copyright © 2017 Alaeddine Me. All rights reserved.
//

import Alamofire

class APIClient {
    
    
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,AFError>)->Void) -> DataRequest {
      return AF.request(route)
        .responseDecodable (decoder: decoder){
          (response: DataResponse<T,AFError>) in
            completion(response.result)
      }
    }
    
    
    
    
    
    @discardableResult
    private static func performRequestNew<T:Decodable>(route:APIRouterNew, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,AFError>)->Void) -> DataRequest {
        return AF.request(route)
                        .responseDecodable (decoder: decoder){
                            
                            (response: DataResponse<T,AFError>) in
                            
                            completion(response.result)
        }
    }
    
    
    
    @discardableResult
    private static func performRequestSimple(route:APIRouter, completion: @escaping (Result<String, AFError>)->Void) -> DataRequest {
        return AF.request(route)
            .responseString(encoding: String.Encoding.utf8) {
                (response) in
                completion(response.result)
        }
    }
    
    @discardableResult
    private static func performRequestSimpleNew(route:APIRouterNew, completion: @escaping (Result<String, AFError>)->Void) -> DataRequest {
        return AF.request(route)
            .responseString(encoding: String.Encoding.utf8) {
                
                (response) in
                
                completion(response.result)
                
        }
    }
    
    
    //----------------------------------------------------
    
    static func login(email:String, password:String, mobile_token:String, completion:@escaping (Result<LoginResponse,AFError>)->Void) {
        
        performRequest(route: APIRouter.login(email: email, password: password, mobile_token: mobile_token), completion: completion)
        
    }
    
    
    static func user_details(completion:@escaping (Result<GetUserResponse,AFError>)->Void) {
        
        performRequest(route: APIRouter.user_details, completion: completion)
        
    }
    
    static func registration(name: String, email: String, password: String, confirm: String, mobile_token: String, image_id: String, completion:@escaping (Result<LoginResponse,AFError>)->Void) {
        
        performRequest(route: APIRouter.registration(name: name, email: email, password: password, confirm: confirm, mobile_token: mobile_token, image_id: image_id), completion: completion)
        
    }
    
    static func logout(completion:@escaping (Result<Logout,AFError>)->Void) {
        
        performRequest(route: APIRouter.logout, completion: completion)
        
    }
    
    static func getOffers(completion:@escaping (Result<OffersResponse,AFError>)->Void) {
        
        performRequest(route: APIRouter.getOffers, completion: completion)
        
    }
    
    static func publish_order(order_description:String,image:String,distance:String,duration:String,promo_code:String,delivery_time:String,order_from_location:String,order_to_location:String,client_location_lat:String,client_location_long:String,order_location_lat:String,order_location_long:String,mobile_token:String, completion:@escaping (Result<OrderResponse,AFError>)->Void) {
           
        performRequest(route: APIRouter.publish_order(order_description: order_description, image: image, distance: distance, duration: duration, promo_code: promo_code, delivery_time: delivery_time, order_from_location: order_from_location, order_to_location: order_to_location, client_location_lat: client_location_lat, client_location_long: client_location_long, order_location_lat: order_location_lat, order_location_long: order_location_long, mobile_token: mobile_token), completion: completion)
           
       }
    
    
    static func acceptOffer(offerID:String, mobile_token:String, completion:@escaping (Result<String,AFError>)->Void) {
        
        performRequestSimple(route: APIRouter.acceptOffer(offerID: offerID, mobile_token: mobile_token), completion: completion)
        
    }
    
    static func rejectOffer(offerID:String, completion:@escaping (Result<AcceptOffersResponse,AFError>)->Void) {
        
        performRequest(route: APIRouter.rejectOffer(offerID: offerID), completion: completion)
        
    }
    
    
    static func getOrders(starLat:String, starLong:String, mobile_token:String, completion:@escaping (Result<GetOrdersResponse,AFError>)->Void) {
        
        performRequest(route: APIRouter.getOrders(starLat: starLat, starLong: starLong, mobile_token: mobile_token), completion: completion)
        
    }
    
    static func submitOffer(starID:String, orderID:String, expected_delivery_time:String, offer_value:String, mobile_token:String, completion:@escaping (Result<String,AFError>)->Void) {
        
        performRequestSimple(route: APIRouter.submitOffer(starID: starID, orderID: orderID, expected_delivery_time: expected_delivery_time, offer_value: offer_value, mobile_token: mobile_token), completion: completion)
        
    }
    
    static func getNotifications(completion:@escaping (Result<NotificationsResponse,AFError>)->Void) {
        
        performRequest(route: APIRouter.getNotifications, completion: completion)
        
    }
    
    static func rate(orderID:String,rate:String,noteID:String,completion:@escaping (Result<RateResponse,AFError>)->Void){
        
        performRequest(route: APIRouter.rate(orderID: orderID, rate: rate, noteID: noteID), completion: completion)
    }
    
    static func finishOrder(orderID:String,billAmount:String,mobile_token:String,completion:@escaping (Result<String,AFError>)->Void){
        
        performRequestSimple(route: APIRouter.finishOrder(orderID: orderID, billAmount: billAmount, mobile_token: mobile_token), completion: completion)
    }
    
    static func cancelOrder(orderID:String,completion:@escaping (Result<String,AFError>)->Void){
        
        performRequestSimple(route: APIRouter.cancelOrder(orderID: orderID), completion: completion)
    }
    
    static func promoCode(promoCode:String,completion:@escaping (Result<PromoCodeResponse,AFError>)->Void){
        
        performRequest(route: APIRouter.promoCode(promo_code: promoCode), completion: completion)
    }
    
    
    static func getBalance(completion:@escaping (Result<BalanceResponse,AFError>)->Void) {
        
        performRequest(route: APIRouter.balance, completion: completion)
        
    }
    
    static func getMyOrders(completion:@escaping (Result<MyOrdersResponse,AFError>)->Void) {
        
        performRequest(route: APIRouter.myOrders, completion: completion)
        
    }
    
    static func getComplaintTypes(completion:@escaping (Result<ComplaintTypesResponse,AFError>)->Void) {
        
        performRequest(route: APIRouter.complaintTypes, completion: completion)
        
    }
    
    static func makeComplaint(orderID:String,complaint_type_id:String,complaint:String,completion:@escaping (Result<String,AFError>)->Void){
        
        performRequestSimple(route: APIRouter.makeComplaint(orderID: orderID, complaint_type_id: complaint_type_id, complaint: complaint), completion: completion)
    }
    
    
    static func changePhone(phone:String,completion:@escaping (Result<String,AFError>)->Void){
        
        performRequestSimple(route: APIRouter.changePhone(phone: phone), completion: completion)
    }
    
    static func changePhoto(image_url:String,completion:@escaping (Result<String,AFError>)->Void){
        
        performRequestSimple(route: APIRouter.addPhoto(image_url: image_url), completion: completion)
    }
    
    
    static func changePassword(password:String, password_confirmation:String,completion:@escaping (Result<String,AFError>)->Void){
        
        performRequestSimple(route: APIRouter.changePassword(password: password, password_confirmation: password_confirmation), completion: completion)
    }
    
    static func switchUser(completion:@escaping (Result<TypesResponse,AFError>)->Void) {
        
        performRequest(route: APIRouter.switchUser, completion: completion)
        
    }

}
