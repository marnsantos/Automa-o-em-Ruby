//
//  APIClient.swift
//  Pescatta
//
//  Created by MacITBAM01 on 12/06/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import Alamofire

class APIClient{
    
    //MARK: - Authentication REST
    
    /**
     # Function that performs a login for external users.
     - Parameter login: The CPF or e-mail of the external user.
     - Parameter password: The password registered for the external user.
     - Returns: A **DataResponse** of type **User** that contains external user data.
     */
    static func login(login: String, password: String, completion:@escaping (DataResponse<User>)->Void) {
        let parameters = ["login":login,
                          "senha":password,
                          "system":"PESCATTU"]
        Alamofire.request(Routes.get_auth_path(), method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: ["Content-Type" :"application/json"]).responseObject { (response: DataResponse<User>) in
            completion(response)
        }
    }
    
    /**
     # Function that performs a login for employee users.
     - Parameter login: The CPF or e-mail of the external user.
     - Parameter password: The password registered for the external user.
     - Returns: A **DataResponse** of type **User** that contains external user data.
     */
    static func login_employee(login: String, password: String, completion:@escaping (DataResponse<User>)->Void) {
        let parameters = ["login":login,
                          "senha":password,
                          "system":"PESCATTU_FUNCIONARIO"]
        Alamofire.request(Routes.get_auth_path(), method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: ["Content-Type" :"application/json"]).responseObject { (response: DataResponse<User>) in
            completion(response)
        }
    }
    
    /**
     # Function that performs a login for social network users
     - Parameter token: The user's token on his social network.
     - Parameter email: The user's name on his social network.
     - Parameter email: The user's email on his social network.
     - Returns: A **DataResponse** of type **User** that contains external user data.
     */
    static func social_network_login(token: String, name: String,email: String, completion:@escaping (DataResponse<User>)->Void) {
        let parameters = ["token":token,
                          "nome":name,
                          "email":email]
       Alamofire.request(Routes.get_auth_path(), method: .post, parameters:parameters , encoding: JSONEncoding.default, headers: ["Content-Type" :"application/json"]).responseObject { (response: DataResponse<User>) in
            completion(response)
        }
    }
    
    /**
     # Function that refreshs user token to not expirate session.
     - Returns: A **DataResponse** of type **User** that contains the refreshed user token.
     */
    static func refresh_token(completion:@escaping (DataResponse<User>)->Void) {
        let userToken = UserDataDAO.get_user_token()
        Alamofire.request(Routes.get_refresh_path(), method: .post, parameters:nil, encoding: JSONEncoding.default, headers: ["Content-Type" :"application/json","Authorization":userToken]).responseObject { (response: DataResponse<User>) in
            completion(response)
        }
    }
    
    /**
     # Function that creates a new external user.
     - Parameter name: The name of the new user.
     - Parameter phone: The phone number of the new user.
     - Parameter email: The email of the new user.
     - Parameter password: The password of the new user.
     - Parameter cpf: The cpf of the new user.
     - Returns: A **DataResponse** of type **User** that contains external user data.
     */
    static func create_user(name: String, phone: String,email: String,password: String,cpf: String, completion:@escaping (DataResponse<User>)->Void) {
        let parameters = ["nome":"\(name)",
                          "phone":phone,
                          "email":email,
                          "password":password,
                          "cpf":cpf,
                          "system":"PESCATTU",
                          "permission":"EXTERNO"]
        Alamofire.request(Routes.get_register_path(), method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: ["Content-Type" :"application/json"]).responseObject { (response: DataResponse<User>) in
            completion(response)
        }
    }
    
    /**
     # Function that creates a new external user.
     - Parameter email: The email of the new transire user.
     - Parameter password: The password of the new transire user.
     - Returns: A **DataResponse** of type **FirstLoginResponse** that contains user registered data.
     */
    static func first_login(email: String, password: String, completion:@escaping (DataResponse<FirstLoginResponse>)->Void) {
        let userId = UserDataDAO.get_transire_unregistered_user_id()
        let userToken = UserDataDAO.get_transire_unregistered_user_token()
        let headers = ["Authorization": "\(userToken)",
                       "Content-Type" :"application/json"]
        let parameters:[String: Any] = ["userId":userId,
                                        "email":email,
                                        "password":password]
        Alamofire.request(Routes.get_first_login_path(), method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse<FirstLoginResponse>) in
            completion(response)
        }
    }
    
    /**
     # Function that sends an email with a new provisory password.
     - Parameter email: the user email.
     - Returns: A ResponseData with the feedback JSON.
     */
    static func recover_password(email: String, completion:@escaping (DataResponse<Any>)->Void) {
        Alamofire.request(Routes.get_recover_password_path(email: email), method: .get, parameters:nil, encoding: JSONEncoding.default, headers: ["Content-Type" :"application/json"]).responseJSON {response in
            completion(response)
        }
    }
    
    /**
     # Function that changes user's current password.
     - Parameter new_password: the user's new password.
     - Parameter current_password: the user's current password.
     - Returns: A ResponseData with the feedback JSON.
     */
    static func save_new_password(new_password: String,current_password: String, completion:@escaping (DataResponse<Any>)->Void) {
        let userId = UserDataDAO.get_user_id()
        let userToken = UserDataDAO.get_user_token()
        let user:[String: Any] = ["id":userId,
                                  "newPasswordDecrypted":new_password,
                                  "password":current_password]
        let headers = ["Authorization": "\(userToken)",
                       "Content-Type" :"application/json"]
        Alamofire.request(Routes.get_change_password_path(), method: .post, parameters:user, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
           completion(response)
        }
    }
    
   //MARK: - Products List REST
    
    /**
     # Function that downloads the promotional products of Pescattu.
     - Returns: A ResponseData of type **Offers**.
     */
    static func download_offers(completion:@escaping (DataResponse<Offers>)->Void) {
         Alamofire.request(Routes.get_offers_path(), method: .get, parameters:nil, encoding: JSONEncoding.default, headers: ["Content-Type" :"application/json"]).responseObject { (response: DataResponse<Offers>) in
            completion(response)
        }
    }
    
    /**
     # Function that downloads the all products of Pescattu.
     - Returns: A ResponseData of type **Offers**.
     */
    static func download_products(completion:@escaping (DataResponse<Offers>)->Void) {
        Alamofire.request(Routes.get_products_path(), method: .get, parameters:nil, encoding: JSONEncoding.default, headers: ["Content-Type" :"application/json"]).responseObject { (response: DataResponse<Offers>) in
            completion(response)
        }
    }
    
    /**
     # Function searchs a promotional product.
     - Parameter term: the term used to search.
     - Returns: A ResponseData of type **Offers**.
     */
    static func search_offers(term:String,completion:@escaping (DataResponse<Offers>)->Void) {
        Alamofire.request(Routes.get_search_offers_path(term: term), method: .get, parameters:nil, encoding: JSONEncoding.default, headers: ["Content-Type" :"application/json"]).responseObject { (response: DataResponse<Offers>) in
            completion(response)
        }
    }
    
    /**
     # Function searchs a promotional product.
     - Parameter term: the term used to search.
     - Returns: A ResponseData of type **Offers**.
     */
    static func search_products(term:String,completion:@escaping (DataResponse<Offers>)->Void) {
      Alamofire.request(Routes.get_search_products_path(term: term), method: .get, parameters:nil, encoding: JSONEncoding.prettyPrinted, headers: ["Content-Type" :"application/json"]).validate().responseObject { (response: DataResponse<Offers>) in
            completion(response)
        }
    }
    
    //MARK: - payment REST
    
    /**
     # Function that returns the balance of a employee
     - Returns: A ResponseData of type **Employee**.
     */
    static func get_employee_balance(completion:@escaping (DataResponse<Employee>)->Void) {
        let userId = UserDataDAO.get_user_id()
        let userToken = UserDataDAO.get_user_token()
        let headers = ["Authorization": "\(userToken)",
                       "Content-Type" :"application/json"]
        Alamofire.request(Routes.get_employee_balance_path(userId: userId), method: .get, parameters:nil, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse<Employee>) in
            completion(response)
        }
    }
    
    /**
     # Function that performs an employee order.
     - Parameter ordersArray: array that contains the itens of user's order.
     - Returns: A ResponseData of type **TOrder**.
     */
    static func perform_employee_order(ordersArray:Array<[String: Any]>,completion:@escaping (DataResponse<TOrder>)->Void) {
        let userId = UserDataDAO.get_user_id()
        let userToken = UserDataDAO.get_user_token()
        let headers = ["Authorization": "\(userToken)",
                       "Content-Type" :"application/json"]
        let parameters = ["userId":userId,
                          "route":0,
                          "salesPersonId":1,
                          "itemList":ordersArray,
                          "payment":1,
                          "operation":1] as [String : Any]
        print(parameters)
        Alamofire.request(Routes.get_employee_order_path(), method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: headers).responseObject {
            (response: DataResponse<TOrder>) in
            completion(response)
        }
    }
    
    /**
     # Function that performs an credit card payment.
     - Returns: A ResponseData of type **TOrder**.
     */
    static func perform_creditcard_payment(addressId:Int,ordersArray:Array<[String: Any]>,pay:Dictionary<String,Any>,completion:@escaping (DataResponse<PaymentResponse>)->Void) {
        let userId = UserDataDAO.get_user_id()
        let userToken = UserDataDAO.get_user_token()
        let parameters = ["addressId":addressId,
                          "userId":userId,
                          "operation":2,
                          "payment":2,
                          "itemList":ordersArray,
                          "pay": pay] as [String : Any]
        let headers = ["Authorization": "\(userToken)",
                       "Content-Type" :"application/json"]
        Alamofire.request(Routes.get_creditcard_payment_path(), method: .post , parameters:parameters, encoding: JSONEncoding.default, headers: headers).responseObject {
            (response: DataResponse<PaymentResponse>) in
            completion(response)
        }
    }
    
    
    //MARK: - Addresses REST
    
    /**
     # Function that downloads user addresses.
     - Returns: A ResponseData of type **Address**.
     */
    static func download_addresses(completion:@escaping (DataResponse<Address>)->Void) {
        let userId = UserDataDAO.get_user_id()
        let userToken = UserDataDAO.get_user_token()
        let headers = ["Content-Type" :"application/json",
                       "Authorization": userToken]
        Alamofire.request(Routes.get_addresses_path(userId: userId), method: .get, parameters:nil, encoding: JSONEncoding.default, headers: headers).responseObject {
            (response: DataResponse<Address>) in
            completion(response)
        }
    }
    
    /**
     # Function that deletes a given address.
     - Parameter addressId: the address id of the address that will be deleted.
     - Returns: A ResponseData of type **AddressResponse**.
     */
    static func delete_address(addressId:Int,completion:@escaping (DataResponse<AddressResponse>)->Void) {
        let userToken = UserDataDAO.get_user_token()
        let headers = ["Authorization": "\(userToken)",
                       "Content-Type" :"application/json"]
        Alamofire.request(Routes.get_delete_address_path(addressId: addressId), method: .delete, parameters:nil, encoding: JSONEncoding.default, headers: headers).responseObject {
            (response: DataResponse<AddressResponse>) in
            completion(response)
        }
    }
    
    /**
     # Function that returns the Address related with a given CEP.
     - Parameter cep: the user postal code.
     - Returns: A ResponseData of type **ViaCepAddress**.
     */
    static func get_viacep_address(cep:String,completion:@escaping (DataResponse<ViaCepAddress>)->Void) {
        let headers = ["Content-Type" :"application/json"]
        Alamofire.request(Routes.get_viacep_path(cep: cep), method: .post, parameters:nil, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<ViaCepAddress>) in
            completion(response)
        }
    }
    
    /**
     # Function that register a new address.
     - Parameter address: the user's street name.
     - Parameter complement: extra data to help delivering service.
     - Parameter neighborhood: the user's neighborhood name.
     - Parameter number: the user's house number.
     - Parameter phone: the user's phone number.
     - Parameter cep: the user's cep number.
     - Returns: A ResponseData of type **Address**.
     */
    static func add_address(address:String,complement:String,neighborhood:String,number:String,phone:String,cep:String,completion:@escaping (DataResponse<Address>)->Void) {
        let userId = UserDataDAO.get_user_id()
        let userToken = UserDataDAO.get_user_token()
        let parameters = ["addressId":0,
                          "street":address,
                          "complement":complement,
                          "borough":neighborhood ,
                          "number":number,
                          "phone":phone,
                          "cep":cep,
                          "userId":userId,
                          "enabled":true] as [String : Any]
        let headers = ["Content-Type" :"application/json",
                       "Authorization": userToken]
        Alamofire.request(Routes.get_add_address_path(), method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: headers).responseObject {
            (response: DataResponse<Address>) in
            completion(response)
        }
    }
    
    /**
     # Function that register a new address.
     - Parameter addressId: Address id to be updated.
     - Parameter address: the user's street name.
     - Parameter complement: extra data to help delivering service.
     - Parameter neighborhood: the user's neighborhood name.
     - Parameter number: the user's house number.
     - Parameter phone: the user's phone number.
     - Parameter cep: the user's cep number.
     - Returns: A ResponseData of type **Address**.
     */
    static func update_address(addressId:Int,address:String,complement:String,neighborhood:String,number:String,phone:String,cep:String,completion:@escaping (DataResponse<Address>)->Void) {
        let userId = UserDataDAO.get_user_id()
        let userToken = UserDataDAO.get_user_token()
        let parameters = ["addressId":addressId,
                          "street":address,
                          "complement":complement,
                          "borough":neighborhood ,
                          "number":number,
                          "phone":phone,
                          "cep":cep,
                          "userId":userId,
                          "enabled":true] as [String : Any]
        let headers = ["Content-Type" :"application/json",
                      "Authorization": userToken]
        Alamofire.request(Routes.get_add_address_path(), method: .post, parameters:parameters, encoding: JSONEncoding.default, headers:headers ).responseObject {
            (response: DataResponse<Address>) in
            completion(response)
        }
    }
    
    //MARK: - Order REST
    
    /**
     # Function that a list of orders of a given user.
     - Returns: A ResponseData of type **OrderHistory**.
     */
    static func get_orders_by_user(completion:@escaping (DataResponse<OrderHistory>)->Void){
        let userId = UserDataDAO.get_user_id()
        let userToken = UserDataDAO.get_user_token()
        let headers = ["Authorization": "\(userToken)",
                       "Content-Type" :"application/json"]
        Alamofire.request(Routes.get_download_orders_path(userId: userId), method: .get, parameters:nil, encoding: JSONEncoding.default, headers: headers).responseObject {
            (response: DataResponse<OrderHistory>) in
            completion(response)
        }
    }
    
    /**
     # Function that returns the current state of a given order.
     - Parameter trackedId: Order id of the order that is being tracked.
     - Returns: A ResponseData of type **TOrder**.
     */
    static func get_order_status(trackedId:Int,completion:@escaping (DataResponse<TOrder>)->Void){
        let userToken = UserDataDAO.get_user_token()
        let headers = ["Authorization": "\(userToken)",
                       "Content-Type" :"application/json"]
        Alamofire.request(Routes.get_order_tracked_path(trackedId: trackedId), method: .get, parameters:nil, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<TOrder>) in
            completion(response)
        }
    }
    
    /**
     # Function that cancels a given order.
     - Parameter trackedId: Order id of the order that will be canceled.
     - Returns: A ResponseData of type **TOrder**.
     */
    static func cancel_order(trackedId:Int,completion:@escaping (DataResponse<TOrder>)->Void){
        let userToken = UserDataDAO.get_user_token()
        let headers = ["Authorization": "\(userToken)",
                       "Content-Type" :"application/json"]
        Alamofire.request(Routes.get_cancel_order_path(trackedId: trackedId), method: .post, parameters:nil, encoding: JSONEncoding.default, headers:headers).responseObject {
            (response: DataResponse<TOrder>) in
            completion(response)
        }
    }
    
}
