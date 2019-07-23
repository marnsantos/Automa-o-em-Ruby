//
//  TOrder.swift
//  Pescatta
//
//  Created by MacITBAM01 on 12/04/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import ObjectMapper

class TOrder: Mappable {
    
    var data:TOrderData!
    var errors:[String]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data   <- map["data"]
        errors <- map["errors"]
    }
    
}

class TOrderData: Mappable {
    
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
