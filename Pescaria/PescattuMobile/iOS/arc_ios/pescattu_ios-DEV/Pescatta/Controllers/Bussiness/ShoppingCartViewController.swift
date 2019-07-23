//
//  ShoppingCartViewController.swift
//  Pescatta
//
//  Created by Andrew Almeida Chaves do Vale on 02/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import Alamofire

class ShoppingCartViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, CartsButtonsDelegate {
    
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbTotalPrice: UILabel!
    @IBOutlet weak var lbQuantityOfItens: UILabel!
    @IBOutlet weak var tbShoppingCart: UITableView!
    @IBOutlet weak var btPayment: UIButton!
    @IBOutlet weak var lbSaldo: UILabel!
    var employeeBalance:Float! = 0.0
    var to_price:Float!
    
    // MARK: - Life cicle methods
    override func viewWillAppear(_ animated: Bool) {
        if (UserDataDAO.check_if_is_transire_user()){
            APIClient.get_employee_balance { response in
                switch response.result {
                case .success (let employee):
                    if response.response?.statusCode == 200 {
                        self.lbSaldo.text = "Seu saldo é: \(CurrencyUtil.convertToCurrency(price: Float(employee.data)! as NSNumber))"
                        self.employeeBalance   = Float(employee.data ?? "0.0")
                        self.lbSaldo.isHidden = false
                    }
                    break
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbShoppingCart.delegate = self
        tbShoppingCart.dataSource = self
        ViewChanges.applyCornerRoundTo(button: btPayment)
        tbShoppingCart.tableFooterView = UIView()
        update_quantity_of_itens()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        if arr_cart.count == 0 {
            lbTotalPrice.isHidden = true
            lbTotal.isHidden = true
            lbQuantityOfItens.isHidden = true
            btPayment.isHidden = true
            PlaceHolderMessage.showPlacheholderMessage(message:"Carrinho vazio.",view: tbShoppingCart,verticalBias: 1.1)
        }else{
            lbTotalPrice.isHidden = false
            lbTotal.isHidden = false
            lbQuantityOfItens.isHidden = false
            btPayment.isHidden = false
            PlaceHolderMessage.showPlacheholderMessage(message:"",view: tbShoppingCart,verticalBias: 1.1)
        }
        return arr_cart.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cart_item_cell", for: indexPath) as! ShoppingCartTableViewCell
        let offer:OfferData = arr_cart[indexPath.section]
        cell.delegate = self
        cell.indexPath = indexPath
        cell.setup_cell(offer: offer)
        calculate_total_price()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return 100
        case .pad:
            return 180
        case .tv:
            return 0
        case .carPlay:
            return 0
        case .unspecified:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Excluir") { (action, indexPath) in
            if arr_cart.count > 1 {
                self.view.makeToast("Removido do carrinho.", duration: 0.75, position: .center)
            }
            arr_cart.remove(at: indexPath.section)
            self.update_quantity_of_itens()
            self.tbShoppingCart.reloadData()
        }
        
        return [delete]
        
    }
    
    // MARK: - Cart methods
    func decrease_quantity(at index: IndexPath) {
        if (arr_cart[index.section].quantity! - 1 >= 1 ){
            arr_cart[index.section].quantity = arr_cart[index.section].quantity! - 1
            tbShoppingCart.reloadData()
        }
    }
    
    func increase_quantity(at index: IndexPath) {
        arr_cart[index.section].quantity = arr_cart[index.section].quantity! + 1
        tbShoppingCart.reloadData()
    }
    
    // MARK: - Bussiness rules
    func calculate_total_price(){
        to_price = 0.0
        for item in arr_cart {
            if (item.isPromotional == 1){
                to_price = to_price + ((item.pricePromotional?.amount!)! * Float(item.quantity!))
            }else if(item.isPromotional == 0){
                if (UserDataDAO.check_if_is_transire_user()) {
                     to_price = to_price + (item.priceWholeSale! * Float(item.quantity!))
                }else{
                    to_price = to_price + (item.priceApp! * Float(item.quantity!))
                }
            }
        }
        lbTotalPrice.text = CurrencyUtil.convertToCurrency(price: to_price as NSNumber)
    }
    
    @IBAction func confirm_buying(_ sender: Any) {
        if (UserDataDAO.check_if_is_logged() == false){
            var alert:UIAlertController!
            alert = UIAlertController(title: "Atenção!", message:"Você precisa estar logado para finalizar a compra. Deseja logar?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { action in
                self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                let login_vc:ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login_vc") as! ViewController
                self.navigationController?.pushViewController(login_vc, animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }else {
            if (arr_cart.count > 0){
                if (UserDataDAO.check_if_is_transire_user()){
                    if (employeeBalance >= to_price) {
                        let alert = UIAlertController(title: "Atenção!", message: "Deseja realmente realizar essa compra?", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { action in
                            self.really_buy()
                        }))
                        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler: nil))
                        self.present(alert, animated: true)
                    }else{
                        self.view.makeToast("Seu saldo não é suficiente.", duration: 1.5, position: .center)
                    }
                }else {
                    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let choose_address_vc:ChooseAddressViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "choose_address_vc") as! ChooseAddressViewController
                    self.navigationController?.pushViewController(choose_address_vc, animated: true)
                }
            }else {
                self.view.makeToast("Não há produtos no carrinho.", duration: 1.5, position: .center)
            }
        }
    }
    
    func really_buy(){
        self.view.makeToastActivity(.center)
        var ordersArray = [[String: Any]]()
        for item in arr_cart {
            var price:Float!
            if (item.isPromotional == 1){
                price = item.pricePromotional?.amount!
            }else if(item.isPromotional == 0){
                if UserDataDAO.check_if_is_transire_user() {
                    price = item.priceWholeSale!
                }else{
                    price = item.priceApp!
                }
            }
            let prod_id:Int  = Int(item.id ?? -1)
            let quantity:Int = Int(item.quantity ?? 0)
            let dict = ["purchaseOrderId":0,
                        "price": price,
                        "productId": prod_id,
                        "quantity": quantity] as NSDictionary
            ordersArray.append(dict as! [String : Any])
        }
        APIClient.perform_employee_order(ordersArray: ordersArray) { response in
            switch response.result {
            case .success(let order):
                self.view.hideToastActivity()
                if response.response?.statusCode == 200 {
                    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                    let order_authorized_vc:OrderAuthorizedViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "order_authorized_vc") as! OrderAuthorizedViewController
                    order_authorized_vc.orderNumber = order.data.orderId
                    self.present(order_authorized_vc, animated: false, completion: nil)
                }else {
                    self.view.makeToast(order.errors[0], duration: 1.5, position: .center)
                }
                break
                
            case .failure(let error):
                self.view.hideToastActivity()
                self.view.makeToast("não foi possível processar seu pedido.", duration: 1.5, position: .center)
                print(error)
            }
        }
    }
    
    func update_quantity_of_itens(){
        if arr_cart.count > 1 {
            lbQuantityOfItens.text = "\(arr_cart.count) itens no carrinho."
        }else if arr_cart.count == 1{
            lbQuantityOfItens.text = "1 item no carrinho."
        }
    }

}
