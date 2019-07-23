//
//  FirstLoginResponse.swift
//  Pescatta
//
//  Created by MacITBAM01 on 17/07/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import ObjectMapper

class FirstLoginResponse: Mappable {
    
    var data:FirstLoginData?
    var errors:[String]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data   <- map["data"]
        errors <- map["errors"]
    }
    
}

class FirstLoginData: Mappable{
    
    var userId:Int!
    var password:String!
    var email:String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId <- map["userId"]
        password <- map["password"]
        email <- map["email"]
    }
}
