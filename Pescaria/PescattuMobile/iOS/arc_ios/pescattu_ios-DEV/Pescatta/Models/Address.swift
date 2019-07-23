//
//  Address.swift
//  Pescatta
//
//  Created by MacITBAM01 on 09/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import ObjectMapper

class Address: Mappable {
    
    var data:[AddressData]!
    var errors:[String]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
        errors <- map["errors"]
    }
    
}

class AddressData: Mappable {
    
    var userId:Int?
    var addressId:Int?
    var borough:String?
    var cep:String?
    var complement:String?
    var number:String?
    var phone:String?
    var street:String?
    var city:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        userId     <- map["userId"]
        addressId  <- map["addressId"]
        borough    <- map["borough"]
        cep        <- map["cep"]
        complement <- map["complement"]
        number     <- map["number"]
        phone      <- map["phone"]
        street     <- map["street"]
        city       <- map["city"]
    }
    
}
