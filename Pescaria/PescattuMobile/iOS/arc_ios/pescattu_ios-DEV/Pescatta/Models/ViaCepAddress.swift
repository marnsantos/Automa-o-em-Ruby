//
//  ViaCepAddress.swift
//  Pescatta
//
//  Created by MacITBAM01 on 03/04/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import ObjectMapper

class ViaCepAddress: Mappable {
    
    var neighborhood:String?
    var street:String?
    var city:String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        neighborhood <- map["bairro"]
        street       <- map["logradouro"]
        city         <- map["localidade"]
    }
    
}
