//
//  PaymentResponse.swift
//  Pescatta
//
//  Created by MacITBAM01 on 12/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import ObjectMapper


class PaymentResponse: Mappable {
    
    var statusMundiPagg:String?  //for cancelling order
    var data:payData?
    var errors:[String]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        statusMundiPagg <- map["statusMundiPagg"]
        data            <- map["data"]
        errors          <- map["errors"]
    }
    
}

class payData: Mappable{
    
    var statusMundiPagg:String?
    var id:Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        statusMundiPagg <- map["statusMundiPagg"]
        id              <- map["id"]
    }
}

