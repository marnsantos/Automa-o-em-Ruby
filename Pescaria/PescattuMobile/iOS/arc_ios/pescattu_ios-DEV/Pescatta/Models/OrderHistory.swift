//
//  OrderHistory.swift
//  Pescatta
//
//  Created by MacITBAM01 on 07/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import ObjectMapper

class OrderHistory: Mappable {
    
    var data:[OrderData]!
    var errors:[String]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data   <- map["data"]
        errors <- map["errors"]
    }
    
}

class OrderData: Mappable {
    
    // JSON MAPPED PROPERTIES
    var orderId:Int?
    var status:String?
    var odate:Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        orderId <- map["id"]
        status  <- map["status"]
        odate  <- map["docDate"]
    }
    
}
