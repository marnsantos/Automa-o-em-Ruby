//
//  PaymentViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 06/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import Alamofire
import GMStepper

class PaymentViewController: UIViewController, UITextFieldDelegate, PickerViewMesSelecionado, PickerViewAnoSelecionado{
    
    @IBOutlet weak var spParcelas: GMStepper!
    @IBOutlet weak var vTotalPrice: UIView!
    @IBOutlet weak var lbTotalPrice: UILabel!
    @IBOutlet weak var tfCardNumber: UITextField!
    @IBOutlet weak var tfValidMounth: UITextField!
    @IBOutlet weak var tfValidYear: UITextField!
    @IBOutlet weak var tfSecurityCode: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfCPF: UITextField!
    @IBOutlet weak var btConfirm: UIButton!
    var to_price:Float!
    var pickerViewMes = PickerViewMes()
    var pickerViewAno = PickerViewAno()
    
    // MARK: - Life cicle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChanges.applyCornerRoundTo(button: btConfirm)
        ViewChanges.applyShadowTo(view: vTotalPrice)
        calculate_total_price()
        pickerViewMes.delegate = self
        pickerViewAno.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Textfields validation
    @IBAction func verififyNumberOfCharacters(_ sender: Any) {
        if (sender as!  UITextField).tag == 10 {
            checkMaxLength(textField: (sender as!  UITextField), maxLength: 16)
        } else if (sender as!  UITextField).tag == 20 || (sender as!  UITextField).tag == 30{
            checkMaxLength(textField: (sender as!  UITextField), maxLength: 2)
        }else if (sender as!  UITextField).tag == 40 {
            checkMaxLength(textField: (sender as!  UITextField), maxLength: 3)
        } else if (sender as!  UITextField).tag == 50 {
            checkMaxLength(textField: (sender as!  UITextField), maxLength: 11)
        }
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if ((textField.text?.count)! > maxLength) {
            textField.deleteBackward()
        }
    }
    
    //MARK: - PickerViewDelegate
    func mesSelecionado(mes: String) {
        tfValidMounth.text = mes
    }
    
    func anoSelecionado(ano: String) {
        tfValidYear.text = "\(ano.suffix(2))"
    }
    
    @IBAction func textFieldMesEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewMes
        pickerView.dataSource = pickerViewMes
        sender.inputView = pickerView
    }
    
    @IBAction func textFieldAnoEntrouEmFoco(_ sender: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = pickerViewAno
        pickerView.dataSource = pickerViewAno
        sender.inputView = pickerView
    }
    
    //MARK: - Bussiness methods
    @IBAction func confirm_payment(_ sender: Any) {
        if (tfCardNumber.text != "" && tfValidMounth.text != "" && tfValidYear.text != "" && tfSecurityCode.text != "" && tfName.text != "" && tfCPF.text != ""){
            var ordersArray = [[String: Any]]()
            self.view.makeToastActivity(.center)
            self.view.isUserInteractionEnabled = false
            for item in arr_cart {
                var price:Float!
                if (item.isPromotional == 1){
                    price = item.pricePromotional?.amount!
                }else if(item.isPromotional == 0){
                    if (UserDataDAO.check_if_is_transire_user()) {
                        price = item.priceWholeSale!
                    }else{
                        price = item.priceApp!
                    }
                }
                let prod_id:Int  = Int(item.id ?? -1)
                let quantity:Int = Int(item.quantity ?? 0)
                let dict = ["price": price,
                            "productId": prod_id,
                            "quantity": quantity] as NSDictionary
                ordersArray.append(dict as! [String : Any])
            }
            let cpf = tfCPF.text ?? ""
            let installments:Int = Int(spParcelas.value)
            let cardNumber = tfCardNumber.text ?? ""
            let holderName = tfName.text ?? ""
            let expMounth:Int = Int(tfValidMounth.text ?? "")!
            let expYear:Int = Int(tfValidYear.text ?? "")!
            let cvv = tfSecurityCode.text ?? ""
            let pay = [ "cpf": cpf,
                        "credit_card":[
                            "installments": installments,
                            "card":[
                                "number": cardNumber,
                                "holder_name": holderName,
                                "exp_month": expMounth,
                                "exp_year": expYear,
                                "cvv": cvv
                            ]
                ]
                ] as [String : Any]
            let choosenAddress:Int = UserDataDAO.get_choosen_address_id()
            print(choosenAddress)
            APIClient.perform_creditcard_payment(addressId: choosenAddress, ordersArray: ordersArray, pay: pay) { response in
                self.view.isUserInteractionEnabled = true
                switch response.result {
                case .success(let paymentResponse):
                    self.view.hideToastActivity()
                    if response.response?.statusCode == 200 {
                        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                        let payment_feedback_vc:PaymentFeedbackViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "payment_feedback_vc") as! PaymentFeedbackViewController
                        payment_feedback_vc.feedback = paymentResponse.data!.statusMundiPagg!
                        payment_feedback_vc.idPedido = paymentResponse.data!.id!
                        self.present(payment_feedback_vc,animated: false)
                    } else{
                        for err in (paymentResponse.errors!) {
                            self.view.makeToast(err, duration: 2.0, position: .center)
                        }
                    }
                    break
                    
                case .failure(let error):
                    self.view.hideToastActivity()
                    self.view.isUserInteractionEnabled = true
                    self.view.makeToast("não foi possível processar seu pedido.", duration: 0.75, position: .center)
                    print(error)
                }
            }
        }else {
            self.view.makeToast("Todos os campos precisam ser preenchidos.", duration: 0.75, position: .center)
        }
    }
    
    // MARK: - Bussiness rules
    func calculate_total_price(){
        to_price = 0.0
        for item in arr_cart {
            if (item.isPromotional == 1){
                to_price = to_price + ((item.pricePromotional?.amount!)! * Float(item.quantity!))
            }else if(item.isPromotional == 0){
                if UserDataDAO.check_if_is_transire_user() {
                    to_price = to_price + (item.priceWholeSale! * Float(item.quantity!))
                }else {
                    to_price = to_price + (item.priceApp! * Float(item.quantity!))
                }
            }
        }
        lbTotalPrice.text = CurrencyUtil.convertToCurrency(price: to_price as NSNumber)
    }
    
    // MARK: - Util methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
