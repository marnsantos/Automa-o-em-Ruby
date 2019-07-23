//
//  Routes.swift
//  Pescatta
//
//  Created by MacITBAM01 on 12/06/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

class Routes {
    //static let host = "http://40.112.193.81:8383"
    static let host = "http://65.52.18.171:8383" //prod
    //static let host = "http://172.100.11.62:8282" //ren
    //static let host = "http://172.100.10.84:8383"
    //static let host = "http://172.100.11.122:8383" //mau
    
    static func get_auth_path() -> String{
        return "\(host)/auth"
    }
    
    static func get_refresh_path() -> String{
        return "\(host)/auth/refresh"
    }
    
    static func get_register_path() -> String{
        return "\(host)/user-mobile/register-manual"
    }
    
    static func get_first_login_path() -> String{
        return "\(host)/user-mobile/first-login/"
    }

    static func get_recover_password_path(email:String) -> String{
        return "\(host)/user-mobile/recover-password/?email=\(email)&system=PESCATTU"
    }
    
    static func get_change_password_path() -> String{
        return "\(host)/user-mobile/change-password"
    }
    
    static func get_offers_path() -> String{
        return "\(host)/product-mob/offers"
    }
    
    static func get_products_path() -> String{
        return "\(host)/product-mob/products"
    }
    
    static func get_search_offers_path(term:String) -> String{
        return "\(host)/product-mob/find-offers?product=\(term)"
    }
    
    static func get_search_products_path(term:String) -> String{
        return "\(host)/product-mob/find-products?product=\(term)"
    }
    
    static func get_employee_balance_path(userId:Int) -> String{
        return "\(host)/employee-mob/get-balance-by-user/\(userId)"
    }
    
    static func get_employee_order_path() -> String{
        return "\(host)/wintec/"
    }
    
    static func get_creditcard_payment_path() -> String{
        return "\(host)/mundipagg/venda"
    }
    
    static func get_addresses_path(userId:Int) -> String{
        return "\(host)/userId/address/\(userId)"
    }
    
    static func get_delete_address_path(addressId:Int) -> String{
        return "\(host)/userId/address/\(addressId)"
    }
    
    static func get_viacep_path(cep:String) -> String{
        return "http://viacep.com.br/ws/\(cep)/json/"
    }
    
    static func get_add_address_path() -> String{
        return "\(host)/userId/address"
    }
    
    static func get_download_orders_path(userId:Int) -> String{
        return "\(host)/purchaseOrderMob/purchase-orders-by-user/\(userId)"
    }
    
    static func get_order_tracked_path(trackedId:Int) -> String{
        return "\(host)/purchaseOrderMob/purchase-order-by-id/\(trackedId)"
    }
    
    static func get_cancel_order_path(trackedId:Int) -> String{
        return "\(host)/mundipagg/cancelar/\(trackedId)"
    }
    
    static func get_image_path(imageName:String) -> String{
        return "\(host)/product-img/\(imageName)"
    }
}
