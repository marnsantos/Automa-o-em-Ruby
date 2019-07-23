//
//  AddressResponse.swift
//  Pescatta
//
//  Created by MacITBAM01 on 18/04/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import ObjectMapper

class AddressResponse: Mappable {
    
    var data:String!
    var errors:[String]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data   <- map["data"]
        errors <- map["errors"]
    }
    
}
