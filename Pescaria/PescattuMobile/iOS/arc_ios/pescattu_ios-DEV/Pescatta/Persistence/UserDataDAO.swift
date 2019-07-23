//
//  UserDataDAO.swift
//  Pescatta
//
//  Created by MacITBAM01 on 13/06/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit

class UserDataDAO {
    
    //MARK: - Keys
    private static let USER_TYPE = "User Type"
    private static let USER_ID = "User Id"
    private static let USER_TOKEN = "User Token"
    private static let UNREGISTERED_TOKEN = "Unregistered Token"
    private static let UNREGISTERED_ID = "Unregistered Id"
    private static let USER_NAME  = "User Name"
    private static let USER_EMAIL = "User Email"
    private static let FLIGHT_TYPE = "flight_type"
    private static let ADDRESS_ID = "address_id"
    
    //MARK: - Values
    private static let SM_USER   = "Social Media User"
    private static let TRAN_USER = "Transire Employee User"
    private static let TRA_USER  = "Traditional User"
    
    //MARK: - Store functions
    private static func save_ordinary_user_data(userName:String,userId:Int,userToken:String,userEmail:String){
        UserDefaults.standard.set(userName, forKey: USER_NAME)
        UserDefaults.standard.set(userId, forKey: USER_ID)
        UserDefaults.standard.set(userToken, forKey: USER_TOKEN)
        UserDefaults.standard.set(userEmail, forKey: USER_EMAIL)
    }
    
    static func save_external_user_data(userName:String,userId:Int,userToken:String,userEmail:String){
        UserDefaults.standard.set(TRA_USER, forKey: USER_TYPE)
        save_ordinary_user_data(userName: userName,userId: userId,userToken: userToken,userEmail: userEmail)
    }
    
    static func save_social_net_user_data(userName:String,userId:Int,userToken:String,userEmail:String){
        UserDefaults.standard.set(SM_USER, forKey: USER_TYPE)
        save_ordinary_user_data(userName: userName,userId: userId,userToken: userToken,userEmail: userEmail)
    }
    
    static func save_transire_user_data(userName:String,userId:Int,userToken:String,userEmail:String){
        UserDefaults.standard.set(TRAN_USER, forKey: USER_TYPE)
        save_ordinary_user_data(userName: userName,userId: userId,userToken: userToken,userEmail: userEmail)
    }
    
    static func save_refreshed_user_token(userToken:String){
        UserDefaults.standard.set(userToken, forKey: USER_TOKEN)
    }
    
    static func save_transire_unregistered_user_token(userToken:String){
        UserDefaults.standard.set(userToken, forKey: UNREGISTERED_TOKEN)
    }
    
    static func save_transire_unregistered_user_id(userId:Int){
        UserDefaults.standard.set(userId, forKey: UNREGISTERED_ID)
    }
    
    static func save_choosen_flight_type(flight_type:Int){
        UserDefaults.standard.set(flight_type, forKey: FLIGHT_TYPE)
    }
    
    static func save_choosen_address_id(addressId:Int){
        UserDefaults.standard.set(addressId, forKey: ADDRESS_ID)
    }
    
    //MARK: - Restore functions
    static func get_choosen_address_id() -> Int{
        return UserDefaults.standard.object(forKey: ADDRESS_ID) as! Int
    }
    
    static func get_flight_type() -> Int{
        return UserDefaults.standard.object(forKey: FLIGHT_TYPE) as! Int
    }
    
    static func get_user_token() -> String{
        return UserDefaults.standard.object(forKey: USER_TOKEN) as! String
    }
    
    static func get_transire_unregistered_user_token() -> String{
        return UserDefaults.standard.object(forKey: UNREGISTERED_TOKEN) as! String
    }
    
    static func get_transire_unregistered_user_id() -> Int{
        return UserDefaults.standard.object(forKey: UNREGISTERED_ID) as! Int
    }
    
    static func get_user_name() -> String{
        if UserDefaults.standard.object(forKey: USER_NAME) == nil {
            return ""
        }
        return UserDefaults.standard.object(forKey: USER_NAME) as! String
    }
    
    static func get_user_id() -> Int{
        return UserDefaults.standard.object(forKey: USER_ID) as! Int
    }
    
    static func get_user_email() -> String{
        if UserDefaults.standard.object(forKey: USER_EMAIL) == nil {
            return ""
        }
        return UserDefaults.standard.object(forKey: USER_EMAIL) as! String
    }
    
    //MARK: - Delete functions
    static func clean_local_data(){
        UserDefaults.standard.removeObject(forKey: USER_NAME)
        UserDefaults.standard.removeObject(forKey: USER_ID)
        UserDefaults.standard.removeObject(forKey: USER_TYPE)
        UserDefaults.standard.removeObject(forKey: USER_EMAIL)
        UserDefaults.standard.removeObject(forKey: USER_TOKEN)
    }
    
    //MARK: - Checking functions
    static func check_if_is_logged() -> Bool{
        if (UserDefaults.standard.object(forKey: USER_TYPE) == nil){
            return false
        }
        return true
    }

    static func check_if_is_transire_user() -> Bool{
        if !check_if_is_logged(){
            return false
        }else if ((UserDefaults.standard.object(forKey: USER_TYPE) as! String) == TRAN_USER) {
            return true
        }
        return false
    }
    
    static func check_if_is_social_media_user() -> Bool{
        if !check_if_is_logged(){
            return false
        }else if ((UserDefaults.standard.object(forKey: USER_TYPE) as! String) == SM_USER) {
            return true
        }
        return false
    }

}
