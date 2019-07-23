//
//  AddAddressViewController.swift
//  Pescatta
//
//  Created by MacITBAM01 on 08/03/2018.
//  Copyright © 2018 Instituto Transire. All rights reserved.
//

import UIKit
import Alamofire

class AddAddressViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfComplement: UITextField!
    @IBOutlet weak var tfNumber: UITextField!
    @IBOutlet weak var tfNeighborhood: UITextField!
    @IBOutlet weak var tfPostalCode: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var btConfirm: UIButton!
    var isEditingAddress:Bool!
    var addressToEdit:AddressData!

    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewChanges.applyCornerRoundTo(button: btConfirm)
        if isEditingAddress {
            self.title = "Editar endereço"
            tfPostalCode.text = addressToEdit.cep
            tfAddress.text = addressToEdit.street
            tfNeighborhood.text = addressToEdit.borough
            tfNumber.text = addressToEdit.number
            tfComplement.text = addressToEdit.complement
            tfPhone.text = addressToEdit.phone
        }else {
            self.title = "Adicionar endereço"
        }
    }

    // MARK: - REST methods
    @IBAction func searchCEP(_ sender: Any) {
        if ((sender as! UITextField).text?.count == 8) {
            APIClient.get_viacep_address(cep: (sender as! UITextField).text!) { response in
                switch response.result {
                    case .success(let address):
                        if (address.city == "Manaus"){
                            self.tfNeighborhood.text = address.neighborhood
                            self.tfAddress.text = address.street
                        }else{
                            self.view.makeToast("Cep inválido, apenas endereços em Manaus/AM.", duration: 1.5, position: .center)
                        }
                        break
                    
                    case .failure(let error):
                        self.view.makeToast("Erro ao procurar endereço.", duration: 1.5, position: .center)
                        self.tfAddress.isEnabled = true
                        self.tfAddress.backgroundColor = UIColor.white
                        self.tfNeighborhood.isEnabled = true
                        self.tfNeighborhood.backgroundColor = UIColor.white
                        print(error)
                }
            }
        }else{
            tfNeighborhood.text = ""
            tfAddress.text = ""
        }
    }
    
    
    @IBAction func confirm_new_address(_ sender: Any) {
        if (tfAddress.text != "" && tfNumber.text != "" && tfNeighborhood.text != "" && tfPostalCode.text != "" && tfPhone.text != "" ){
            self.view.makeToastActivity(.center)
            if isEditingAddress {
                update_address()
            }else{
                add_address()
            }
        }else {
            self.view.makeToast("Todos os campos, exceto complemento, são obrigatórios.", duration: 0.75, position: .center)
        }
    }
    
    func add_address(){
        let address:String = tfAddress.text ?? ""
        let complement:String = tfComplement.text ?? ""
        let neighborhood:String = tfNeighborhood.text ?? ""
        let number:String = tfNumber.text ?? ""
        let phone:String = tfPhone.text ?? ""
        let cep:String = tfPostalCode.text ?? ""
        APIClient.add_address(address: address, complement: complement, neighborhood: neighborhood, number: number, phone: phone, cep: cep) { response in
            switch response.result {
            case .success(let address):
                self.view.hideToastActivity()
                if response.response?.statusCode == 200 {
                    self.view.makeToast("Endereço salvo com sucesso.", duration: 0.75, position: .center)
                    self.navigationController?.popViewController(animated: true)
                }else {
                    self.view.makeToast(address.errors[0], duration: 0.75, position:.center)
                }
                break
                
            case .failure(let error):
                self.view.hideToastActivity()
                self.view.makeToast("Não foi possível cadastrar seu endereço. Verifique sua conexão.", duration: 0.75, position: .center)
                print(error)
            }
        }
    } 
    
    func update_address(){
        let address:String = tfAddress.text ?? ""
        let complement:String = tfComplement.text ?? ""
        let neighborhood:String = tfNeighborhood.text ?? ""
        let number:String = tfNumber.text ?? ""
        let phone:String = tfPhone.text ?? ""
        let cep:String = tfPostalCode.text ?? ""
        APIClient.update_address(addressId: addressToEdit.addressId!, address: address, complement: complement, neighborhood: neighborhood, number: number, phone: phone, cep: cep) { response in
            switch response.result {
            case .success(let address):
                self.view.hideToastActivity()
                if response.response?.statusCode == 200 {
                    self.view.makeToast("Endereço salvo com sucesso.", duration: 0.75, position: .center)
                    self.navigationController?.popViewController(animated: true)
                }else {
                    self.view.makeToast(address.errors[0], duration: 0.75, position:.center)
                }
                break
                
            case .failure(let error):
                self.view.hideToastActivity()
                self.view.makeToast("Não foi possível atualizar seu endereço. Verifique sua conexão.", duration: 0.75, position: .center)
                print(error)
            }
        }
    }
    
    //MARK: - Textfields validation methods
    @IBAction func limit_characters(_ sender: Any) {
        checkMaxLength(textField: (sender as!  UITextField), maxLength: 13)
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if ((textField.text?.count)! > maxLength) {
            textField.deleteBackward()
        }
    }
    
    //MARK: - Util methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
