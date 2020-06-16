//
//  UserDefult.swift
//  Eschoola
//
//  Created by Admin on 6/6/19.
//  Copyright © 2019 amirahmed. All rights reserved.
//

import Foundation

struct UserDefault {

    static let token = "token"

    //-------------------------
    
    static let isLogedIn = "isLogedIn"
    
    static let fingerprint = "fingerprint"
    
    static let orderID = "orderID"
    
    static let orderDeliveryTime = "orderDeliveryTime"
    
    static let promoCode = "promoCode"
    
    static let orderActive = "orderActive"
    
    //-------------------------
    
    static let id = "id"
    static let type = "type"
    static let name = "Name"
    static let email = "Email"
    static let password = "Password"
    static let age = "Age"
    static let gender = "Gender"
    static let work = "Work"
    static let mobile = "Mobile"
    static let images = "Images"
    
    
    //----------------
    
    static func setToken(_ token:String){
        UserDefaults.standard.set(token, forKey: self.token)
    }
    
    static func getToken() -> String {
        return  UserDefaults.standard.string(forKey: self.token) ?? ""
    }
    
    static func setPromoCode(_ promoCode:String){
        UserDefaults.standard.set(promoCode, forKey: self.promoCode)
    }
    
    static func getPromoCode() -> String {
        return  UserDefaults.standard.string(forKey: self.promoCode) ?? ""
    }
    
    static func setorderID(_ orderID:String){
        UserDefaults.standard.set(orderID, forKey: self.orderID)
    }
    
    static func getorderID() -> String {
        return  UserDefaults.standard.string(forKey: self.orderID) ?? ""
    }
    
    static func setorderDeliveryTime(_ orderDeliveryTime:String){
        UserDefaults.standard.set(orderDeliveryTime, forKey: self.orderDeliveryTime)
    }
    
    static func getorderDeliveryTime() -> String {
        return  UserDefaults.standard.string(forKey: self.orderDeliveryTime) ?? ""
    }
    
    static func setID(_ id:Int){
        UserDefaults.standard.set(id, forKey: self.id)
    }
    
    static func getID() -> Int {
        return  UserDefaults.standard.integer(forKey: self.id)
    }
    
    static func setType(_ type:Int){
        UserDefaults.standard.set(type, forKey: self.type)
    }
    
    static func getType() -> Int {
        return  UserDefaults.standard.integer(forKey: self.type)
    }
    
    static func setName(_ name:String){
        UserDefaults.standard.set(name, forKey: self.name)
    }
    
    static func getName() -> String {
        return  UserDefaults.standard.string(forKey: self.name) ?? ""
    }
    
    static func setEmail(_ email:String){
        UserDefaults.standard.set(email, forKey: self.email)
    }
    
    static func getEmail() -> String {
        return  UserDefaults.standard.string(forKey: self.email) ?? ""
    }
    
    static func setPassword(_ pass:String){
        UserDefaults.standard.set(pass, forKey: self.password)
    }
    
    static func getPassword() -> String {
        return  UserDefaults.standard.string(forKey: self.password) ?? ""
    }
    
    static func setAge(_ age:String){
        UserDefaults.standard.set(age, forKey: self.age)
    }
    
    static func getAge() -> String {
        return  UserDefaults.standard.string(forKey: self.age) ?? ""
    }
    
    static func setGender(_ gender:String){
        UserDefaults.standard.set(gender, forKey: self.gender)
    }
    
    static func getGender() -> String {
        return  UserDefaults.standard.string(forKey: self.gender) ?? ""
    }
    
    static func setWork(_ work:String){
        UserDefaults.standard.set(work, forKey: self.work)
    }
    
    static func getWork() -> String {
        return  UserDefaults.standard.string(forKey: self.work) ?? ""
    }
    
    static func setMobile(_ mobile:String){
        UserDefaults.standard.set(mobile, forKey: self.mobile)
    }
    
    static func getMobile() -> String {
        return  UserDefaults.standard.string(forKey: self.mobile) ?? ""
    }
    
    static func setImage(_ image:String){
        UserDefaults.standard.set(image, forKey: self.images)
    }
    
    static func getImage() -> String {
        return  UserDefaults.standard.string(forKey: self.images) ?? ""
    }
    
    //----------------
    
    static func isOrderActive() -> Bool {
        if(UserDefaults.standard.string(forKey: self.orderActive) == "True")
        {
            return true
        }else
        {
            return false
        }
        
    }
    
    static func activateOrder(){
        UserDefaults.standard.set("True", forKey: self.orderActive)
    }
    
    static func deactivateOrder(){
        UserDefaults.standard.set("False", forKey: self.orderActive)
    }

    static func enableFingerPrint(){
        UserDefaults.standard.set("True", forKey: self.fingerprint)
    }
    
    static func disableFingerPrint(){
        UserDefaults.standard.set("False", forKey: self.fingerprint)
    }
    
    static func setLogin(){
        UserDefaults.standard.set("True", forKey: self.isLogedIn)
    }
    
    static func setLogout(){
        UserDefaults.standard.set("False", forKey: self.isLogedIn)
    }
    
    static func isLoggedIn() -> Bool {
        if(UserDefaults.standard.string(forKey: self.isLogedIn) == "True")
        {
            return true
        }else
        {
            return false
        }
        
    }
    
    static func isFingerprint() -> Bool {
        if(UserDefaults.standard.string(forKey: self.fingerprint) == "True")
        {
            return true
        }else
        {
            return false
        }
        
    }

    //--------------------------
   
   static func isLogin() -> Bool {
      return UserDefaults.standard.object(forKey: self.token) != nil && UserDefaults.standard.string(forKey: self.token) != ""
   }
    
   
   static func save(_ object:String ,_ key:String) {
       UserDefaults.standard.set( object,forKey: key)
   }
   
   static func retrive(_ key:String)->String? {
      return  UserDefaults.standard.string(forKey: key)
   }
   
   static func saveBool(_ object:Bool ,_ key:String) {
      UserDefaults.standard.set( object,forKey: key)
   }
   
   static func retriveBool(_ key:String)->Bool {
      return  UserDefaults.standard.bool(forKey: key)
   }
}
