//
//  Offer.swift
//  Pescatta
//
//  Created by Andrew Almeida Chaves do Vale on 05/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import ObjectMapper

class Offers: Mappable {
    
    var data:[OfferData]!
    var errors:[String]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data   <- map["data"]
        errors <- map["errors"]
    }
    
}

class OfferData: Mappable {
    
    // JSON MAPPED PROPERTIES
    var descriptionn:String!
    var name:String!
    var priceApp:Float!
    var priceWholeSale:Float!
    var cod:String!
    var id:Int!
    var imageList:[String]!
    var pricePromotional:PricePromotional?
    
    // USED IN CART PROPERTY
    var quantity:Int?
    var isPromotional:Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        var sPriceM:Any!
        sPriceM           <- map["priceApp"]
        var sPriceS:Any!
        sPriceS           <- map["priceWholeSale"]
        descriptionn      <- map["description"]
        name              <- map["name"]
        priceApp          =  (sPriceM as! NSNumber).floatValue
        priceWholeSale    =  (sPriceS as! NSNumber).floatValue
        cod               <- map["productCod"]
        id                <- map["productId"]
        imageList         <- map["imageList"]
        pricePromotional  <- map["pricePromotional"]
    }
    
}

class PricePromotional: Mappable{
    
    var amount:Float!

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        var sPriceA:Any!
        sPriceA <- map["amount"]
        amount  = (sPriceA as! NSNumber).floatValue
    }
    
}
