//
//  User.swift
//  Pescatta
//
//  Created by MacITBAM01 on 10/04/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {
    
    var data:authData?
    var errors:[String]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data   <- map["data"]
        errors <- map["errors"]
    }
    
}

class authData: Mappable{
    
    var id:Int!
    var name:String!
    var token:String!
    var email:String!
    var permissoes:[String]!
    var firstLogin:Bool!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        name  <- map["nome"]
        token <- map["token"]
        email <- map["email"]
        permissoes <- map["permissoes"]
        firstLogin <- map["firstLogin"]
    }
}
